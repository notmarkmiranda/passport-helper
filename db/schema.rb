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

ActiveRecord::Schema.define(version: 20160609003000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "passports", force: :cascade do |t|
    t.string   "name"
    t.date     "start"
    t.date     "expiration"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
  end

  create_table "specials", force: :cascade do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.integer  "passport_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "specials", ["passport_id"], name: "index_specials_on_passport_id", using: :btree
  add_index "specials", ["venue_id"], name: "index_specials_on_venue_id", using: :btree

  create_table "user_passports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "passport_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_passports", ["passport_id"], name: "index_user_passports_on_passport_id", using: :btree
  add_index "user_passports", ["user_id"], name: "index_user_passports_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "name"
    t.string   "image_url"
    t.string   "url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "uid"
    t.string   "password_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "neighborhood"
    t.string   "website"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "specials", "passports"
  add_foreign_key "specials", "venues"
  add_foreign_key "user_passports", "passports"
  add_foreign_key "user_passports", "users"
end
