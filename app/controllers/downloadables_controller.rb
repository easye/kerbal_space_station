class DownloadablesController < ApplicationController
  before_filter :authenticate_account!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :find_downloadable, only: [:show, :edit, :update, :destroy, :ignore, :bookmark, :like, :dislike, :download]

  def index
    @downloadables = Downloadable.type(type).order(:created_at).decorate
  end

  def show
  end

  def new
    @_downloadable = current_account.send(contexts).build and build_images
    @downloadable = @_downloadable.decorate
  end

  def create
    @_downloadable = current_account.send(contexts).build(valid_params)
    persist_or_render(:new)
  end

  def edit
    build_images(@_downloadable.images.size)
  end

  def update
    @_downloadable.assign_attributes(valid_params)
    persist_or_render(:edit)
  end

  def destroy
    @_downloadable.destroy
    flash[:notice] = "You've deleted #{@downloadable.name}."
    redirect_to url_for(controller: contexts, action: :index)
  end

  def like
    vote(:like, @_downloadable)
  end

  def dislike
    vote(:dislike, @_downloadable)
  end

  def bookmark
    unless current_account.bookmarks?(@_downloadable)
      current_account.bookmark(@_downloadable)
      current_account.increment!(:bookmark_count)
      redirect_back_and_flash "bookmarked", @downloadable
    else
      current_account.unbookmark(@_downloadable)
      current_account.decrement!(:bookmark_count)
      redirect_back_and_flash "unbookmarked", @downloadable
    end
  end

  def download
    @_downloadable.increment!(:download_count)
    redirect_to @downloadable.download
  end

  private

  def vote(choice, downloadable)
    unless current_account.send(:"#{choice}s?", downloadable)
      current_account.send(choice, downloadable)
    else
      current_account.send(:"un#{choice}", downloadable)
    end
    redirect_back_and_flash("#{choice}d", downloadable)
  end

  def find_downloadable
    @_downloadable = Downloadable.type(type).where(id: params[:id]).first
    unless @_downloadable.present?
      flash[:alert] = "That #{@_downloadable} either no longer exists or never existed."
      redirect_to url_for(controller: contexts, action: :index)
    end
    @downloadable = @_downloadable.decorate if @_downloadable
  end

  def contexts
    params[:controller]
  end

  def context
    contexts.singularize
  end

  def type
    context.capitalize
  end

  def valid_params
    params[context].slice(*type.constantize::VALID_PARAMS)
  end

  def build_images(number = 3)
    (3 - number).times { @_downloadable.images.build }
  end

  def redirect_back_and_flash(action, resource)
    flash[:notice] = "You've #{action} #{resource.name}." and redirect_to :back
  end

  def persist_or_render(failed_view)
    form = DownloadableTagForm.new(@_downloadable, params[context][:tags])
    if form.valid?
      form.save!
      flash[:notice] = "Your #{context} has been saved!"
      redirect_to(@_downloadable)
    else
      report_errors(@_downloadable) and build_images(@_downloadable.images.size)
      render(failed_view)
    end
  end
end
