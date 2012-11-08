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

ActiveRecord::Schema.define(:version => 20121108030758) do

  create_table "chairs", :force => true do |t|
    t.string   "abbr"
    t.string   "chief"
    t.string   "faculty"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "gpo_id"
  end

  create_table "participants", :force => true do |t|
    t.integer  "project_id"
    t.integer  "course"
    t.string   "edu_group"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mid_name"
    t.integer  "gpo_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "participants", ["project_id"], :name => "index_participants_on_project_id"

  create_table "projects", :force => true do |t|
    t.text     "analysis"
    t.text     "expected_results"
    t.text     "features"
    t.text     "forecast"
    t.text     "funds_required"
    t.text     "funds_sources"
    t.text     "goal"
    t.text     "novelty"
    t.text     "purpose"
    t.text     "release_cost"
    t.text     "source_data"
    t.text     "stakeholders"
    t.string   "title"
    t.integer  "gpo_id"
    t.integer  "theme_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "gpo_id"
  end

end
