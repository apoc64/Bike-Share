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

ActiveRecord::Schema.define(version: 2018_06_05_024122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string "title"
    t.string "image", default: "http://fixmfg.com/wp-content/uploads/2017/02/WheelieWrench_angleLR.jpg"
    t.decimal "price"
    t.boolean "is_retired?", default: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accessory_orders", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.bigint "order_id"
    t.bigint "accessory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_accessory_orders_on_accessory_id"
    t.index ["order_id"], name: "index_accessory_orders_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.date "installation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "start_station_id"
    t.integer "end_station_id"
    t.index ["end_station_id"], name: "index_trips_on_end_station_id"
    t.index ["start_station_id"], name: "index_trips_on_start_station_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accessory_orders", "accessories"
  add_foreign_key "accessory_orders", "orders"
  add_foreign_key "orders", "users"
end
