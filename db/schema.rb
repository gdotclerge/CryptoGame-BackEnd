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

ActiveRecord::Schema.define(version: 20180208151654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "portfolios", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ticker_id"
    t.float "purchase_amount"
    t.float "purchase_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticker_id"], name: "index_portfolios_on_ticker_id"
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "tickers", force: :cascade do |t|
    t.integer "rank"
    t.string "search_term"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.float "unspent_money", default: 1000.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "portfolios", "tickers"
  add_foreign_key "portfolios", "users"
end
