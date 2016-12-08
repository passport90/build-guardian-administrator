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

ActiveRecord::Schema.define(version: 20161208163546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "engineers", force: :cascade do |t|
    t.string   "slack_username",                 null: false
    t.date     "duty_date"
    t.boolean  "duty_fulfilled", default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["duty_date"], name: "index_engineers_on_duty_date", unique: true, using: :btree
    t.index ["slack_username"], name: "index_engineers_on_slack_username", unique: true, using: :btree
  end

end
