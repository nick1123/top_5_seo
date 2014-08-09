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

  create_table "posts", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "category"
    t.integer  "clicks"
    t.integer  "votes_up"
    t.integer  "votes_down"
    t.integer  "points"
    t.text     "voting_ip_addresses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["category", "url"], name: "index_posts_on_category_and_url", unique: true, using: :btree
  add_index "posts", ["created_at"], name: "index_posts_on_created_at", using: :btree
  add_index "posts", ["points"], name: "index_posts_on_points", using: :btree

end
