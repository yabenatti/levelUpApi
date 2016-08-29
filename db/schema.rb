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

ActiveRecord::Schema.define(version: 20160826202000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_tokens", force: :cascade do |t|
    t.integer  "user_id",              null: false
    t.integer  "platform",             null: false
    t.string   "authentication_token", null: false
    t.datetime "last_used_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["user_id", "authentication_token"], name: "index_authentication_tokens_on_user_id_and_authentication_token", unique: true, using: :btree
    t.index ["user_id"], name: "index_authentication_tokens_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "description"
    t.string   "image"
    t.datetime "date"
    t.integer  "likes"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",           null: false
    t.string   "password_digest"
    t.string   "pet_name"
    t.integer  "beacon_id"
    t.datetime "birth_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["beacon_id"], name: "index_users_on_beacon_id", using: :btree
  end

  add_foreign_key "authentication_tokens", "users"
end
