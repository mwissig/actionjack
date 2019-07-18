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

ActiveRecord::Schema.define(version: 2019_07_18_030442) do

  create_table "blackjacks", force: :cascade do |t|
    t.integer "player_id"
    t.string "room_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "friends", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipient_id"
    t.boolean "accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gamechats", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.string "game_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "category"
    t.integer "shop_price"
    t.integer "sellback_price"
    t.integer "user_set_price"
    t.string "color"
    t.string "material"
    t.string "quality"
    t.text "description"
    t.text "long_description"
    t.string "string1"
    t.string "string2"
    t.integer "integer1"
    t.integer "integer2"
    t.datetime "datetime1"
    t.datetime "datetime2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "lobbychats", force: :cascade do |t|
    t.integer "user_id"
    t.string "body"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mineplayers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "deltax"
    t.integer "deltay"
    t.string "coords"
    t.string "pickaxe"
    t.integer "axelvl"
    t.integer "speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "sender_id"
    t.text "body"
    t.string "game"
    t.integer "game_id"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read"
  end

  create_table "pictionaries", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "last_online"
    t.integer "current_score"
    t.integer "all_time_score"
    t.boolean "turn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "username"
    t.string "color"
    t.text "desc"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "online_at"
  end

  create_table "shopitems", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "shop_price"
    t.integer "sellback_price"
    t.string "color"
    t.string "material"
    t.string "quality"
    t.text "description"
    t.text "long_description"
    t.string "string1"
    t.string "string2"
    t.integer "integer1"
    t.integer "integer2"
    t.datetime "datetime1"
    t.datetime "datetime2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "slots", force: :cascade do |t|
    t.integer "jackpot"
    t.integer "last_winner_id"
    t.integer "last_win_prize"
    t.datetime "last_win_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "biggest_prize"
    t.integer "biggest_winner_id"
    t.datetime "biggest_win_date"
  end

  create_table "tictactoes", force: :cascade do |t|
    t.integer "x_id"
    t.integer "o_id"
    t.string "a1"
    t.string "b1"
    t.string "c1"
    t.string "a2"
    t.string "b2"
    t.string "c2"
    t.string "a3"
    t.string "b3"
    t.string "c3"
    t.integer "x_wins"
    t.integer "o_wins"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "turn"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "time_zone"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "admin", default: false
    t.boolean "banned_from_chat", default: false
    t.datetime "ban_until"
    t.integer "points", default: 1000
    t.integer "wins", default: 0
    t.integer "losses", default: 0
    t.datetime "time_since_daily_bonus", default: "2019-06-11 20:41:34"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
