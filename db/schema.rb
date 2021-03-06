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

ActiveRecord::Schema.define(version: 2018_10_22_090517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "currency"
    t.integer "amount"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "bank"
    t.string "currency"
    t.bigint "number"
    t.integer "month"
    t.integer "year"
    t.integer "ccv"
    t.integer "amount"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "amount"
    t.bigint "from_user_id"
    t.bigint "to_user_id"
    t.bigint "from_account_id"
    t.bigint "to_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_account_id"], name: "index_transactions_on_from_account_id"
    t.index ["from_user_id"], name: "index_transactions_on_from_user_id"
    t.index ["to_account_id"], name: "index_transactions_on_to_account_id"
    t.index ["to_user_id"], name: "index_transactions_on_to_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "cards", "users"
  add_foreign_key "transactions", "accounts", column: "from_account_id"
  add_foreign_key "transactions", "accounts", column: "to_account_id"
  add_foreign_key "transactions", "users", column: "from_user_id"
  add_foreign_key "transactions", "users", column: "to_user_id"
end
