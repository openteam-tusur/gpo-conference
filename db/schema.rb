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

ActiveRecord::Schema.define(:version => 20121120093153) do

  create_table "chairs", :force => true do |t|
    t.string   "abbr"
    t.string   "chief"
    t.string   "faculty"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "gpo_id"
  end

  create_table "claims", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "state"
    t.string   "type"
    t.integer  "theme_id"
    t.integer  "conference_id"
  end

  add_index "claims", ["project_id"], :name => "index_claims_on_project_id"
  add_index "claims", ["theme_id"], :name => "index_claims_on_theme_id"
  add_index "claims", ["user_id"], :name => "index_claims_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "discourse_id"
    t.text     "body"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "ancestry"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["discourse_id"], :name => "index_comments_on_discourse_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "conferences", :force => true do |t|
    t.string   "year"
    t.date     "starts_on"
    t.date     "ends_on"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "discourses", :force => true do |t|
    t.string   "vfs_path"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "title"
    t.string   "authors"
  end

  add_index "discourses", ["project_id"], :name => "index_discourses_on_project_id"

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "role"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "permissions", ["user_id", "role", "context_id", "context_type"], :name => "by_user_and_role_and_context"

  create_table "projects", :force => true do |t|
    t.integer  "gpo_id"
    t.integer  "theme_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
    t.integer  "chair_id"
    t.string   "cipher"
  end

  add_index "projects", ["chair_id"], :name => "index_projects_on_chair_id"

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "gpo_id"
    t.integer  "conference_id"
  end

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.text     "name"
    t.text     "email"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "raw_info"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

end
