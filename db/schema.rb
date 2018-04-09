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

ActiveRecord::Schema.define(version: 20160118105206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default"
    t.integer  "order"
  end

  create_table "complaint_movements", force: true do |t|
    t.integer  "complaint_id"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaint_statuses", force: true do |t|
    t.integer  "status_id"
    t.string   "remarks"
    t.datetime "on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "compliant_id"
    t.integer  "complaint_id"
    t.integer  "handler_id"
  end

  create_table "complaint_types", force: true do |t|
    t.string   "problem"
    t.string   "solution"
    t.integer  "handler_id"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaints", force: true do |t|
    t.integer  "complaint_type_id"
    t.string   "remarks"
    t.string   "location"
    t.date     "date_since"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.string   "room_no"
    t.string   "contact_no"
    t.string   "intercom"
    t.string   "name"
  end

  create_table "contacts", force: true do |t|
    t.string   "room_no"
    t.integer  "office_id"
    t.string   "contact_no"
    t.string   "intercom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "name"
    t.integer  "designation_id"
    t.boolean  "active"
  end

  add_index "contacts", ["designation_id"], name: "index_contacts_on_designation_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designations", force: true do |t|
    t.string   "name"
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "designation_code"
  end

  create_table "feedback_replies", force: true do |t|
    t.integer  "feedback_id"
    t.string   "reply_text"
    t.datetime "replied_on"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedback_replies", ["feedback_id"], name: "index_feedback_replies_on_feedback_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.string   "feedback_text"
    t.integer  "contact_id"
    t.datetime "submitted_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["contact_id"], name: "index_feedbacks_on_user_id_id", using: :btree

  create_table "handlers", force: true do |t|
    t.string   "name"
    t.string   "room_no"
    t.string   "floor"
    t.string   "contact_no"
    t.string   "intercom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "homes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offices", force: true do |t|
    t.string   "name"
    t.string   "room_no"
    t.string   "floor"
    t.string   "incharge_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact_no"
    t.string   "mobile"
    t.string   "email"
    t.string   "intercom"
    t.integer  "parent_office_id"
    t.string   "designation"
    t.integer  "incharge_id"
  end

  add_index "offices", ["parent_office_id"], name: "index_offices_on_parent_office_id", using: :btree

  create_table "sections", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sectionofficer_id"
    t.integer  "undersecretary_id"
    t.integer  "director_id"
    t.integer  "js_id"
  end

  create_table "senders", force: true do |t|
    t.string   "name"
    t.string   "designation"
    t.string   "org"
    t.string   "address1"
    t.string   "address2"
    t.string   "country",          limit: 2
    t.string   "state",            limit: 2
    t.string   "city"
    t.string   "pincode"
    t.string   "mobile"
    t.string   "email"
    t.string   "landline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vip_reference_id"
  end

  add_index "senders", ["vip_reference_id"], name: "index_senders_on_vip_reference_id", using: :btree

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "statuses", force: true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", force: true do |t|
    t.string   "name"
    t.integer  "num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
    t.integer  "user_type_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vip_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default"
    t.string   "s_name"
    t.integer  "category_id"
  end

  add_index "vip_categories", ["category_id"], name: "index_vip_categories_on_category_id", using: :btree

  create_table "vip_ref_movements", force: true do |t|
    t.integer  "sent_to"
    t.datetime "sent_on"
    t.text     "remarks"
    t.integer  "sent_by"
    t.integer  "vip_reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read_flag"
    t.datetime "read_time"
  end

  add_index "vip_ref_movements", ["vip_reference_id"], name: "index_vip_ref_movements_on_vip_reference_id", using: :btree

  create_table "vip_ref_status_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vip_ref_statuses", force: true do |t|
    t.string   "status_name"
    t.string   "status_desc"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default"
    t.integer  "order"
  end

  create_table "vip_ref_summaries", force: true do |t|
    t.text     "summary_text"
    t.integer  "vip_reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  add_index "vip_ref_summaries", ["creator_id"], name: "index_vip_ref_summaries_on_creator_id", using: :btree
  add_index "vip_ref_summaries", ["vip_reference_id"], name: "index_vip_ref_summaries_on_vip_reference_id", using: :btree

  create_table "vip_ref_transfers", force: true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.string   "remarks"
    t.datetime "transferred_on"
    t.integer  "user_id"
    t.integer  "vip_reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vip_ref_transfers", ["from_id"], name: "index_vip_ref_transfers_on_from_id", using: :btree
  add_index "vip_ref_transfers", ["to_id"], name: "index_vip_ref_transfers_on_to_id", using: :btree
  add_index "vip_ref_transfers", ["user_id"], name: "index_vip_ref_transfers_on_user_id", using: :btree
  add_index "vip_ref_transfers", ["vip_reference_id"], name: "index_vip_ref_transfers_on_vip_reference_id", using: :btree

  create_table "vip_references", force: true do |t|
    t.string   "letter_no"
    t.date     "letter_date"
    t.text     "subject"
    t.date     "diaried_date"
    t.integer  "diaried_by"
    t.string   "sender_name"
    t.integer  "section_id"
    t.integer  "vip_ref_status_id"
    t.integer  "vip_category_id"
    t.date     "received_on"
    t.string   "eoffice_receipt_no"
    t.string   "eoffice_file_no"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
    t.integer  "user_id"
  end

  add_index "vip_references", ["section_id"], name: "index_vip_references_on_section_id", using: :btree
  add_index "vip_references", ["user_id"], name: "index_vip_references_on_user_id", using: :btree
  add_index "vip_references", ["vip_category_id"], name: "index_vip_references_on_vip_category_id", using: :btree
  add_index "vip_references", ["vip_ref_status_id"], name: "index_vip_references_on_vip_ref_status_id", using: :btree

end
