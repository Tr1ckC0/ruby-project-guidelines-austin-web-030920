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

ActiveRecord::Schema.define(version: 20200324203218) do

  create_table "cards", force: :cascade do |t|
    t.string  "name"
    t.string  "mana_cost"
    t.integer "total_mana_cost"
    t.string  "color"
    t.string  "mana_type"
    t.string  "types"
    t.string  "subtypes"
    t.string  "rarity"
    t.string  "set"
    t.string  "text"
    t.integer "power"
    t.integer "toughness"
    t.string  "legality"
    t.string  "imageURL"
  end

  create_table "deck_cards", force: :cascade do |t|
    t.integer "deck_id"
    t.integer "card_id"
  end

end
