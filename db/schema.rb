# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130510055238) do

  create_table "accounts", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.binary   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "accounts", ["authentication_token"], :name => "index_accounts_on_authentication_token"
  add_index "accounts", ["confirmation_token"], :name => "index_accounts_on_confirmation_token"
  add_index "accounts", ["email"], :name => "index_accounts_on_email"
  add_index "accounts", ["reset_password_token"], :name => "index_accounts_on_reset_password_token"
  add_index "accounts", ["unlock_token"], :name => "index_accounts_on_unlock_token"
  add_index "accounts", ["username"], :name => "index_accounts_on_username"

  create_table "downloadables", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "compatible"
    t.text     "description"
    t.text     "changelog"
    t.text     "install"
    t.integer  "account_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "upload"
    t.integer  "download_count", :default => 0
    t.integer  "bookmark_count", :default => 0
    t.string   "source"
    t.text     "license"
    t.text     "file"
    t.string   "type"
  end

  add_index "downloadables", ["account_id"], :name => "index_downloadables_on_account_id"
  add_index "downloadables", ["bookmark_count"], :name => "index_downloadables_on_bookmark_count"
  add_index "downloadables", ["compatible"], :name => "index_downloadables_on_compatible"
  add_index "downloadables", ["download_count"], :name => "index_downloadables_on_download_count"
  add_index "downloadables", ["name"], :name => "index_downloadables_on_name"
  add_index "downloadables", ["source"], :name => "index_downloadables_on_source"
  add_index "downloadables", ["type"], :name => "index_downloadables_on_type"
  add_index "downloadables", ["upload"], :name => "index_downloadables_on_upload"
  add_index "downloadables", ["version"], :name => "index_downloadables_on_version"

  create_table "downloadables_tags", :force => true do |t|
    t.integer "tag_id"
    t.integer "downloadable_id"
  end

  add_index "downloadables_tags", ["downloadable_id"], :name => "index_downloadables_tags_on_downloadable_id"
  add_index "downloadables_tags", ["tag_id"], :name => "index_downloadables_tags_on_tag_id"

  create_table "images", :force => true do |t|
    t.string   "image"
    t.boolean  "primary"
    t.integer  "downloadable_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "images", ["downloadable_id"], :name => "index_images_on_downloadable_id"
  add_index "images", ["image"], :name => "index_images_on_image"
  add_index "images", ["primary"], :name => "index_images_on_primary"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
