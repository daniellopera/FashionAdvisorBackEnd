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

ActiveRecord::Schema.define(version: 20150416162355) do

  create_table "brands", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "comment",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "outfit_id",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "followers_following", id: false, force: :cascade do |t|
    t.integer "user_id",      limit: 4
    t.integer "following_id", limit: 4
  end

  add_index "followers_following", ["user_id", "following_id"], name: "index_followers_following_on_user_id_and_following_id", using: :btree

  create_table "outfits", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.float    "rating",      limit: 24
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "outfits_products", id: false, force: :cascade do |t|
    t.integer "outfit_id",  limit: 4
    t.integer "product_id", limit: 4
  end

  add_index "outfits_products", ["outfit_id", "product_id"], name: "index_outfits_products_on_outfit_id_and_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products_users", id: false, force: :cascade do |t|
    t.integer "product_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  add_index "products_users", ["product_id", "user_id"], name: "index_products_users_on_product_id_and_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "outfit_id",  limit: 4
    t.boolean  "rating",     limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token",   limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
