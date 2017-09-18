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

ActiveRecord::Schema.define(version: 20170910050018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupon_shop_lists", force: :cascade do |t|
    t.string   "telephone_number"
    t.string   "shop_name"
    t.string   "shop_address"
    t.float    "shop_latitude"
    t.float    "shop_longtitude"
    t.boolean  "all_day_flag"
    t.datetime "open_time"
    t.datetime "close_time"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "shop_management_id"
    t.string   "occupation_code"
    t.string   "holiday"
    t.boolean  "holiday_condition"
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "shop_name"
    t.text     "coupon_content"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "shop_address"
    t.datetime "available_start_time"
    t.datetime "available_end_time"
    t.string   "coupon_shop_lists_id"
  end

  create_table "shop_managers", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "shop_managers", ["email"], name: "index_shop_managers_on_email", unique: true, using: :btree
  add_index "shop_managers", ["reset_password_token"], name: "index_shop_managers_on_reset_password_token", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "name"
    t.string   "type"
    t.string   "status",                 limit: 2
    t.string   "used_shop_manage_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
