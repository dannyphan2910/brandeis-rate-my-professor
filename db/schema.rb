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

ActiveRecord::Schema.define(version: 2020_03_06_183438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_ratings", force: :cascade do |t|
    t.integer "review_id"
    t.integer "cat1"
    t.integer "cat2"
    t.integer "cat3"
    t.integer "cat4"
    t.integer "cat5"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "professor_id"
    t.string "semester"
    t.integer "year"
    t.string "course_title"
    t.string "course_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "professor_ratings", force: :cascade do |t|
    t.integer "review_id"
    t.integer "cat1"
    t.integer "cat2"
    t.integer "cat3"
    t.integer "cat4"
    t.integer "cat5"
    t.string "strength"
    t.string "improvement"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "professors", force: :cascade do |t|
    t.string "prof_first_name"
    t.string "prof_last_name"
    t.string "prof_email"
    t.string "dept_name"
    t.string "prof_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "review_forms", force: :cascade do |t|
    t.bigint "review_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_review_forms_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.string "title"
    t.integer "rate_up"
    t.integer "rate_down"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
