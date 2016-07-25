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

ActiveRecord::Schema.define(version: 20160725130049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "firstname",      null: false
    t.string   "lastname",       null: false
    t.string   "street_address", null: false
    t.string   "city",           null: false
    t.string   "zip",            null: false
    t.string   "phone",          null: false
    t.integer  "country_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["country_id"], name: "index_addresses_on_country_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "authors", force: :cascade do |t|
    t.string   "firstname",   null: false
    t.string   "lastname",    null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title",             null: false
    t.text     "short_description"
    t.text     "description"
    t.integer  "author_id"
    t.integer  "category_id"
    t.decimal  "price"
    t.string   "image"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["author_id"], name: "index_books_on_author_id", using: :btree
    t.index ["category_id"], name: "index_books_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "name"
    t.integer  "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "expiration_month"
    t.string   "expiration_year"
    t.string   "code"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "name"
    t.decimal  "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "total"
    t.date     "completed_date"
    t.integer  "status"
    t.integer  "user_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "delivery_id"
    t.integer  "credit_card_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "use_billing_address"
    t.integer  "coupon_id"
    t.index ["billing_address_id"], name: "index_orders_on_billing_address_id", using: :btree
    t.index ["coupon_id"], name: "index_orders_on_coupon_id", using: :btree
    t.index ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
    t.index ["delivery_id"], name: "index_orders_on_delivery_id", using: :btree
    t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "orders_items", force: :cascade do |t|
    t.integer  "book_id"
    t.decimal  "count"
    t.decimal  "cost"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_orders_items_on_book_id", using: :btree
    t.index ["order_id"], name: "index_orders_items_on_order_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "text"
    t.string   "rating"
    t.integer  "status",          default: 0
    t.string   "reviewable_type"
    t.integer  "reviewable_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "credit_card_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.index ["billing_address_id"], name: "index_users_on_billing_address_id", using: :btree
    t.index ["credit_card_id"], name: "index_users_on_credit_card_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["shipping_address_id"], name: "index_users_on_shipping_address_id", using: :btree
  end

  add_foreign_key "addresses", "countries"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "categories"
  add_foreign_key "orders", "coupons"
  add_foreign_key "orders_items", "books"
  add_foreign_key "orders_items", "orders"
  add_foreign_key "reviews", "users"
  add_foreign_key "users", "credit_cards"
end
