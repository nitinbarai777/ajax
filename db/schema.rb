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

ActiveRecord::Schema.define(:version => 20120718123750) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.integer  "city_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "areas", ["city_id"], :name => "index_areas_on_city_id"

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_provider_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "carriers", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "coupons", :force => true do |t|
    t.string   "name"
    t.string   "price"
    t.integer  "free_coupon"
    t.string   "image"
    t.integer  "min_purchase"
    t.text     "description"
    t.boolean  "up_comming"
    t.text     "address"
    t.text     "highlights"
    t.text     "term_conditions"
    t.text     "offer"
    t.boolean  "is_active"
    t.integer  "coupontype_id"
    t.integer  "merchant_location_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.date     "valid_from"
    t.date     "valid_to"
  end

  add_index "coupons", ["coupontype_id"], :name => "index_coupons_on_coupontype_id"
  add_index "coupons", ["merchant_location_id"], :name => "index_coupons_on_merchant_location_id"

  create_table "coupontypes", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "gateways", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "merchant_locations", :force => true do |t|
    t.string   "latitude"
    t.string   "longitude"
    t.text     "address"
    t.string   "contact"
    t.string   "contact_person"
    t.string   "email"
    t.integer  "city_id"
    t.integer  "area_id"
    t.integer  "merchant_id"
    t.integer  "category_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "merchant_locations", ["area_id"], :name => "index_merchant_locations_on_area_id"
  add_index "merchant_locations", ["category_id"], :name => "index_merchant_locations_on_category_id"
  add_index "merchant_locations", ["city_id"], :name => "index_merchant_locations_on_city_id"
  add_index "merchant_locations", ["merchant_id"], :name => "index_merchant_locations_on_merchant_id"

  create_table "merchants", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.decimal  "price",       :precision => 10, :scale => 0
    t.datetime "released_at"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "user_coupons", :force => true do |t|
    t.string   "message"
    t.string   "message_id"
    t.string   "message_status"
    t.string   "error_text"
    t.integer  "user_id"
    t.integer  "coupon_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "provider"
  end

  add_index "user_coupons", ["coupon_id"], :name => "index_user_coupons_on_coupon_id"
  add_index "user_coupons", ["user_id"], :name => "index_user_coupons_on_user_id"

  create_table "user_providers", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "mobile_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.string   "carrier_id",        :limit => 4
    t.integer  "gateway_id"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "contact"
    t.string   "image"
    t.integer  "is_admin"
    t.boolean  "is_active",                      :default => true
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.date     "birth_date"
    t.date     "anniversary_date"
  end

  add_index "users", ["carrier_id"], :name => "index_users_on_carrier_id"
  add_index "users", ["gateway_id"], :name => "index_users_on_gateway_id"

end
