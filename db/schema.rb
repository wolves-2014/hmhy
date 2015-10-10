# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141202232922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "age_groups", force: :cascade do |t|
    t.string   "generation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assessments", force: :cascade do |t|
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competencies", force: :cascade do |t|
    t.integer  "assessment_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "competencies", ["assessment_id"], name: "index_competencies_on_assessment_id", using: :btree
  add_index "competencies", ["provider_id"], name: "index_competencies_on_provider_id", using: :btree

  create_table "feelings", force: :cascade do |t|
    t.string   "word"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indications", force: :cascade do |t|
    t.integer  "feeling_id"
    t.integer  "assessment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indications", ["assessment_id"], name: "index_indications_on_assessment_id", using: :btree
  add_index "indications", ["feeling_id"], name: "index_indications_on_feeling_id", using: :btree

  create_table "insurances", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.integer "zip_code"
    t.float   "latitude"
    t.float   "longitude"
  end

  add_index "locations", ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude", using: :btree

  create_table "networks", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "insurance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "networks", ["insurance_id"], name: "index_networks_on_insurance_id", using: :btree
  add_index "networks", ["provider_id"], name: "index_networks_on_provider_id", using: :btree

  create_table "providers", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "title"
    t.string   "name"
    t.string   "photo_url"
    t.string   "profile_url"
    t.string   "email"
    t.string   "phone_number"
    t.boolean  "sliding_scale", default: false
    t.integer  "min_price",     default: 0
    t.integer  "max_price",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["location_id"], name: "index_providers_on_location_id", using: :btree

  create_table "targets", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "age_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "targets", ["age_group_id"], name: "index_targets_on_age_group_id", using: :btree
  add_index "targets", ["provider_id"], name: "index_targets_on_provider_id", using: :btree

end
