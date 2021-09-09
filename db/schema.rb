# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_09_211646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ativos", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nome"
    t.integer "quantidade"
    t.float "preco"
    t.float "emolumentos"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_ativos_on_user_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_buyers_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "user_id"
    t.integer "due_day"
    t.date "updated"
    t.date "best_day"
    t.boolean "status", default: true
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "amount"
    t.date "due_date"
    t.integer "partial"
    t.integer "total_partial"
    t.string "comment"
    t.date "date"
    t.string "description"
    t.bigint "user_id"
    t.bigint "credit_card_id"
    t.bigint "buyer_id"
    t.float "total_amount"
    t.integer "month_due"
    t.integer "month_date"
    t.integer "year_date"
    t.integer "flag"
    t.integer "day_due"
    t.bigint "category_id"
    t.index ["buyer_id"], name: "index_payments_on_buyer_id"
    t.index ["category_id"], name: "index_payments_on_category_id"
    t.index ["credit_card_id"], name: "index_payments_on_credit_card_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "tipos", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nome"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_tipos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ativos", "users"
  add_foreign_key "buyers", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "payments", "buyers"
  add_foreign_key "payments", "categories"
  add_foreign_key "payments", "credit_cards"
  add_foreign_key "payments", "users"
  add_foreign_key "tipos", "users"
end
