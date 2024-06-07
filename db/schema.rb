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

ActiveRecord::Schema[7.1].define(version: 2024_06_07_121419) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "album_pokemons", force: :cascade do |t|
    t.bigint "album_id", null: false
    t.bigint "pokemon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_pokemons_on_album_id"
    t.index ["pokemon_id"], name: "index_album_pokemons_on_pokemon_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_albums_on_collection_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "exchange_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pokemon_id", null: false
    t.string "postal_code"
    t.boolean "reserved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokemon_id"], name: "index_exchange_requests_on_pokemon_id"
    t.index ["user_id"], name: "index_exchange_requests_on_user_id"
  end

  create_table "extensions", force: :cascade do |t|
    t.string "extension_name"
    t.string "extension_acronym"
    t.bigint "season_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total"
    t.index ["season_id"], name: "index_extensions_on_season_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "pokemon_name"
    t.string "pokemon_id"
    t.string "pokemon_index"
    t.string "category"
    t.string "rarity"
    t.string "image"
    t.jsonb "metadata", default: {}
    t.bigint "extension_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extension_id"], name: "index_pokemons_on_extension_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "season_name"
    t.string "season_acronym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "album_pokemons", "albums"
  add_foreign_key "album_pokemons", "pokemons"
  add_foreign_key "albums", "collections"
  add_foreign_key "collections", "users"
  add_foreign_key "exchange_requests", "pokemons"
  add_foreign_key "exchange_requests", "users"
  add_foreign_key "extensions", "seasons"
  add_foreign_key "pokemons", "extensions"
end
