class ModDecorator < DownloadableDecorator
  delegate_all

  def filepicker_options
    {
      mimetypes: ["application/zip"],
      services: ["COMPUTER"],
      button_text: "Upload Zip",
      drag_text: "Drop your zip file here.",
      button_class: "btn btn-success",
      multiple: false
    }
  end

end
