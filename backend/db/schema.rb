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

ActiveRecord::Schema.define(version: 2019_10_30_172447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredient", force: :cascade do |t|
    t.string "name"
    t.integer "como_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "como_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "journal_entries", force: :cascade do |t|
    t.datetime "entered"
    t.integer "overall_rating"
    t.integer "concern_1_rating"
    t.integer "concern_2_rating"
    t.integer "concern_3_rating"
    t.string "img_front"
    t.string "img_left"
    t.string "img_right"
    t.string "img_other"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "journal_entry", force: :cascade do |t|
    t.datetime "entered"
    t.integer "overall_rating"
    t.integer "concern_1_rating"
    t.integer "concern_2_rating"
    t.integer "concern_3_rating"
    t.string "img_front"
    t.string "img_left"
    t.string "img_right"
    t.string "img_other"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product", force: :cascade do |t|
    t.string "brand"
    t.string "name"
    t.string "category"
    t.string "img_url"
    t.string "sunscreen_type"
    t.string "spf"
    t.string "pa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_ingredient", force: :cascade do |t|
    t.integer "product_id"
    t.integer "ingredient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_ingredients", force: :cascade do |t|
    t.integer "product_id"
    t.integer "ingredient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "brand"
    t.string "name"
    t.string "category"
    t.string "img_url"
    t.string "sunscreen_type"
    t.string "spf"
    t.string "pa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "routine", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.boolean "current"
    t.string "comment"
    t.string "dicont_bc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "routines", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.boolean "current"
    t.date "started"
    t.date "ended"
    t.string "comment"
    t.string "dicont_bc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "step", force: :cascade do |t|
    t.integer "routine_id"
    t.integer "product_id"
    t.string "name"
    t.string "days"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "steps", force: :cascade do |t|
    t.integer "routine_id"
    t.integer "product_id"
    t.string "name"
    t.string "days"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user", force: :cascade do |t|
    t.string "name"
    t.string "goals"
    t.string "concern_1"
    t.string "concern_2"
    t.string "concern_3"
    t.string "loved_ing"
    t.string "avoid_ing"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_product", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.boolean "current"
    t.integer "rating"
    t.boolean "wishlist"
    t.date "opened"
    t.date "expires"
    t.boolean "caused_acne"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_products", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.boolean "current"
    t.integer "rating"
    t.boolean "wishlist"
    t.date "opened"
    t.date "expires"
    t.boolean "caused_acne"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "goals"
    t.string "concern_1"
    t.string "concern_2"
    t.string "concern_3"
    t.string "loved_ing"
    t.string "avoid_ing"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
