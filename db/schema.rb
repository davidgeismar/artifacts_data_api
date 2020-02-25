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

ActiveRecord::Schema.define(version: 2020_02_15_101004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "birth_year"
    t.string "death_year"
    t.string "period"
    t.string "original_title1"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lots", force: :cascade do |t|
    t.jsonb "dump"
    t.string "title1"
    t.string "title2"
    t.string "original_object_id"
    t.integer "primary_price"
    t.integer "secondary_price"
    t.string "price_label"
    t.string "currency"
    t.integer "low_estimate"
    t.integer "high_estimate"
    t.uuid "sale_id"
    t.uuid "artist_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_lots_on_artist_id"
    t.index ["original_object_id", "sale_id"], name: "index_lots_on_original_object_id_and_sale_id", unique: true
    t.index ["sale_id"], name: "index_lots_on_sale_id"
  end

  create_table "sale_organizers", force: :cascade do |t|
    t.string "company_name"
  end

  create_table "sales", force: :cascade do |t|
    t.jsonb "dump"
    t.string "title"
    t.string "original_id"
    t.string "location"
    t.string "currency"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "total"
    t.uuid "sale_organizer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["original_id", "sale_organizer_id"], name: "index_sales_on_original_id_and_sale_organizer_id", unique: true
    t.index ["sale_organizer_id"], name: "index_sales_on_sale_organizer_id"
  end

end
