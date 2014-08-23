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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140808204105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "category_posts", force: true do |t|
    t.integer  "post_id",                          null: false
    t.string   "category",                         null: false
    t.date     "on_date",                          null: false
    t.integer  "clicks",              default: 0
    t.integer  "votes_up",            default: 0
    t.integer  "votes_down",          default: 0
    t.integer  "points",              default: 0
    t.text     "voting_ip_addresses", default: ""
    t.text     "click_ip_addresses",  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_posts", ["category", "post_id"], name: "index_category_posts_on_category_and_post_id", unique: true, using: :btree
  add_index "category_posts", ["category"], name: "index_category_posts_on_category", using: :btree
  add_index "category_posts", ["on_date"], name: "index_category_posts_on_on_date", using: :btree
  add_index "category_posts", ["points"], name: "index_category_posts_on_points", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "host"
    t.date     "on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["url"], name: "index_posts_on_url", unique: true, using: :btree

end
