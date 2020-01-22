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

ActiveRecord::Schema.define(version: 2020_01_22_041334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_movies_on_title"
  end

  create_table "movies_searches", id: false, force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "search_id", null: false
    t.index ["movie_id", "search_id"], name: "index_movies_searches_on_movie_id_and_search_id"
    t.index ["search_id", "movie_id"], name: "index_movies_searches_on_search_id_and_movie_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "query", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["query"], name: "index_searches_on_query"
  end

end
