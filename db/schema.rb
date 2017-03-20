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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170320092203) do

  create_table "emails", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "username"
    t.string   "password"
    t.string   "server"
    t.integer  "port"
    t.string   "login"
    t.boolean  "ssl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emails_on_user_id"
  end

  create_table "filters", force: :cascade do |t|
    t.integer  "email_id"
    t.text     "filters"
    t.string   "mailbox"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_id"], name: "index_filters_on_email_id"
  end

  create_table "mailentries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "filter_id"
    t.integer  "user_file_id"
    t.text     "content"
    t.string   "message_id"
    t.datetime "received_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["filter_id"], name: "index_mailentries_on_filter_id"
    t.index ["message_id"], name: "index_mailentries_on_message_id"
    t.index ["received_at"], name: "index_mailentries_on_received_at"
    t.index ["user_file_id"], name: "index_mailentries_on_user_file_id"
    t.index ["user_id"], name: "index_mailentries_on_user_id"
  end

  create_table "user_file_groups", force: :cascade do |t|
    t.string   "desc"
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_user_file_groups_on_name"
  end

  create_table "user_file_groups_files", force: :cascade do |t|
    t.integer "user_file_id"
    t.integer "user_file_group_id"
    t.index ["user_file_group_id"], name: "index_user_file_groups_files_on_user_file_group_id"
    t.index ["user_file_id"], name: "index_user_file_groups_files_on_user_file_id"
  end

  create_table "user_files", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "content"
    t.string   "orig"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_files_on_user_id"
  end

  create_table "user_files_user_file_groups", force: :cascade do |t|
    t.integer "user_file_id"
    t.integer "user_file_group_id"
    t.index ["user_file_group_id"], name: "index_user_files_user_file_groups_on_user_file_group_id"
    t.index ["user_file_id"], name: "index_user_files_user_file_groups_on_user_file_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
