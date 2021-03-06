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

ActiveRecord::Schema.define(version: 2020_04_17_033427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", limit: 255
    t.integer "stock", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "rental_price", precision: 8, scale: 2, default: "0.0", null: false
    t.index ["name"], name: "index_movies_on_name", unique: true
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
    t.index ["movie_id"], name: "index_purchases_on_movie_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.integer "quantity", default: 0, null: false
    t.string "status", null: false
    t.datetime "due_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_rentals_on_movie_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "birthdate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "purchases", "movies"
  add_foreign_key "purchases", "users"
  add_foreign_key "rentals", "movies"
  add_foreign_key "rentals", "users"
end
