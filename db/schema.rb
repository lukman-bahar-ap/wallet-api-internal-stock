# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 8) do
  create_table "stock_ownerships", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "stock_id"
    t.string "stock_owner_type", null: false
    t.bigint "stock_owner_id", null: false
    t.integer "shares", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_stock_ownerships_on_stock_id"
    t.index ["stock_owner_id", "stock_owner_type"], name: "index_stock_ownerships_on_stock_owner_id_and_stock_owner_type"
    t.index ["stock_owner_type", "stock_owner_id"], name: "index_stock_ownerships_on_stock_owner"
  end

  create_table "stocks", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "stock_name", limit: 100, null: false
    t.string "symbol", limit: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_name"], name: "index_stocks_on_stock_name", unique: true
    t.index ["symbol"], name: "index_stocks_on_symbol", unique: true
  end

  create_table "team_members", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.integer "is_lead", limit: 1, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_members_on_team_id"
    t.index ["user_id"], name: "index_team_members_on_user_id"
  end

  create_table "teams", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "team_name", limit: 50, null: false
    t.string "email", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_teams_on_email", unique: true
    t.index ["team_name"], name: "index_teams_on_team_name", unique: true
  end

  create_table "user_logins", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "loginable_type", null: false
    t.bigint "loginable_id", null: false
    t.string "username", limit: 100, null: false
    t.string "password_digest", limit: 60, null: false
    t.string "session_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loginable_type", "loginable_id"], name: "index_user_logins_on_loginable"
    t.index ["loginable_type", "loginable_id"], name: "index_user_logins_on_loginable_type_and_loginable_id"
    t.index ["username"], name: "index_user_logins_on_username", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "customer_name", limit: 50, null: false
    t.string "email", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_name"], name: "index_users_on_customer_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wallet_transactions", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "wallet_id"
    t.integer "transaction_type", limit: 1, default: 0, null: false
    t.integer "transaction_category", limit: 1, default: 0, null: false
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.bigint "source_wallet_id"
    t.bigint "target_wallet_id"
    t.integer "qty_transaction_stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_wallet_id"], name: "index_wallet_transactions_on_source_wallet_id"
    t.index ["target_wallet_id"], name: "index_wallet_transactions_on_target_wallet_id"
    t.index ["wallet_id"], name: "index_wallet_transactions_on_wallet_id"
  end

  create_table "wallets", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "walletable_type"
    t.bigint "walletable_id"
    t.decimal "balance", precision: 15, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["walletable_type", "walletable_id"], name: "index_wallets_on_walletable"
  end

  add_foreign_key "stock_ownerships", "stocks"
  add_foreign_key "team_members", "teams"
  add_foreign_key "team_members", "users"
  add_foreign_key "wallet_transactions", "wallets"
  add_foreign_key "wallet_transactions", "wallets", column: "source_wallet_id"
  add_foreign_key "wallet_transactions", "wallets", column: "target_wallet_id"
end
