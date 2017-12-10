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

ActiveRecord::Schema.define(version: 20171203112652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_coupon_service_shop_masters", force: :cascade do |t|
    t.string   "subsidiary_company_name"
    t.string   "parent_company_name"
    t.string   "coupon_content"
    t.string   "business_category_code"
    t.string   "company_mail_address"
    t.string   "telephone_number"
    t.string   "shop_master_id",               null: false
    t.datetime "available_service_start_date", null: false
    t.datetime "available_service_end_date",   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "coupon_shop_lists", force: :cascade do |t|
    t.string   "telephone_number"
    t.string   "shop_name"
    t.string   "shop_address"
    t.float    "shop_latitude"
    t.float    "shop_longtitude"
    t.boolean  "all_day_flag"
    t.datetime "open_time"
    t.datetime "close_time"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "holiday"
    t.boolean  "holiday_condition"
    t.string   "shop_master_id"
    t.string   "occupation_code"
    t.string   "branch_office_id"
    t.string   "subsidiary_company_name"
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "shop_name"
    t.text     "coupon_title"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "shop_address"
    t.datetime "available_start_time"
    t.datetime "available_end_time"
    t.string   "coupon_shop_lists_id"
    t.integer  "coupon_shop_list_id"
    t.string   "coupon_content"
  end

  create_table "general_users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "occupation"
    t.string   "address"
    t.string   "birthday"
    t.string   "nationality"
    t.string   "sex"
  end

  add_index "general_users", ["email"], name: "index_general_users_on_email", unique: true, using: :btree
  add_index "general_users", ["reset_password_token"], name: "index_general_users_on_reset_password_token", unique: true, using: :btree

  create_table "relation_shops", force: :cascade do |t|
    t.string   "name"
    t.string   "shop_master_id"
    t.string   "shop_manager_id"
    t.integer  "not_used"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "relation_shops", ["shop_manager_id", "shop_master_id"], name: "index_relation_shops_on_shop_manager_id_and_shop_master_id", unique: true, using: :btree

  create_table "shop_managers", force: :cascade do |t|
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.string   "occupation"
    t.string   "address"
    t.string   "birthday"
    t.string   "nationality"
    t.string   "sex"
    t.string   "branch_office_id"
    t.string   "status",                   limit: 2
    t.string   "used_branch_office_id"
    t.boolean  "multi_store_manager_flag"
    t.integer  "employee_status"
    t.integer  "register_shop_count"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
