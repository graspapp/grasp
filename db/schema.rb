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

ActiveRecord::Schema.define(version: 20131008095946) do

  create_table "comments", force: true do |t|
    t.string   "content"
    t.string   "commenter_name"
    t.integer  "concept_progress_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["created_at"], name: "index_comments_on_created_at"

  create_table "concept_progresses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "enrollment_id"
    t.integer  "concept_id"
    t.integer  "level"
    t.text     "type_of_error"
    t.text     "next_steps"
  end

  create_table "concepts", force: true do |t|
    t.integer  "unit_id"
    t.string   "number"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "concept_progress_id"
  end

  create_table "courses", force: true do |t|
    t.integer  "teacher_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "enrollments", force: true do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "students", force: true do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true

  create_table "tasks", force: true do |t|
    t.string   "status"
    t.string   "content"
    t.integer  "concept_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "school",                 default: "", null: false
    t.string   "city",                   default: "", null: false
    t.string   "state",                  default: "", null: false
    t.string   "country",                default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["email"], name: "index_teachers_on_email", unique: true
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true

  create_table "units", force: true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
