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

ActiveRecord::Schema.define(version: 20170326140014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "name"
    t.float    "cursor_size"
    t.float    "width"
    t.float    "height"
    t.text     "background_image"
    t.text     "foreground_image"
    t.text     "win_text"
    t.text     "lose_text"
    t.json     "expiration"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "email_templates", force: :cascade do |t|
    t.string   "template_type"
    t.string   "subject"
    t.text     "body"
    t.integer  "card_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["card_id"], name: "index_email_templates_on_card_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_type"
    t.json     "variables"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_events_on_project_id", using: :btree
  end

  create_table "offers", force: :cascade do |t|
    t.float    "win_probability"
    t.json     "instructions"
    t.integer  "max_wins"
    t.json     "max_plays_player"
    t.json     "coupon"
    t.integer  "card_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["card_id"], name: "index_offers_on_card_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "email_address"
    t.string   "ip_address"
    t.string   "first_name"
    t.integer  "plays"
    t.datetime "last_played_at"
    t.integer  "card_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["card_id"], name: "index_players_on_card_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.string   "product_hunt_url"
    t.integer  "product_hunt_votes"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "avatar_url"
    t.string   "client_id"
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "stats", force: :cascade do |t|
    t.string   "stat_type"
    t.string   "ip_address"
    t.text     "browser"
    t.text     "referrer_url"
    t.integer  "offer_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["offer_id"], name: "index_stats_on_offer_id", using: :btree
    t.index ["user_id"], name: "index_stats_on_user_id", using: :btree
  end

  create_table "suggestions", force: :cascade do |t|
    t.text     "message"
    t.string   "email_address"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_suggestions_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.json     "settings"
    t.string   "stripe_customer_id"
    t.integer  "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["team_id"], name: "index_users_on_team_id", using: :btree
  end

  add_foreign_key "email_templates", "cards"
  add_foreign_key "events", "projects"
  add_foreign_key "offers", "cards"
  add_foreign_key "players", "cards"
  add_foreign_key "projects", "users"
  add_foreign_key "stats", "offers"
  add_foreign_key "stats", "users"
  add_foreign_key "suggestions", "users"
  add_foreign_key "users", "teams"
end
