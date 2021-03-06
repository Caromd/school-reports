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

ActiveRecord::Schema.define(version: 20160712080239) do

  create_table "grades", force: :cascade do |t|
    t.string   "name"
    t.string   "year"
    t.integer  "student_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "level_id"
  end

  add_index "grades", ["level_id"], name: "index_grades_on_level_id"
  add_index "grades", ["student_id"], name: "index_grades_on_student_id"
  add_index "grades", ["user_id"], name: "index_grades_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "groups_terms", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "term_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "levels", ["user_id"], name: "index_levels_on_user_id"

  create_table "markpercents", force: :cascade do |t|
    t.string   "mark1_label"
    t.integer  "mark1_percentage"
    t.string   "mark2_label"
    t.integer  "mark2_percentage"
    t.integer  "subject_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "level_id"
  end

  add_index "markpercents", ["level_id"], name: "index_markpercents_on_level_id"
  add_index "markpercents", ["subject_id"], name: "index_markpercents_on_subject_id"
  add_index "markpercents", ["user_id"], name: "index_markpercents_on_user_id"

  create_table "reports", force: :cascade do |t|
    t.string   "teacher"
    t.text     "teacher_comment"
    t.string   "principal"
    t.text     "principal_comment"
    t.integer  "student_id"
    t.integer  "term_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "reports", ["student_id"], name: "index_reports_on_student_id"
  add_index "reports", ["term_id"], name: "index_reports_on_term_id"
  add_index "reports", ["user_id"], name: "index_reports_on_user_id"

  create_table "results", force: :cascade do |t|
    t.decimal  "classmark"
    t.decimal  "testmark"
    t.text     "comment"
    t.integer  "report_id"
    t.integer  "subject_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "results", ["report_id"], name: "index_results_on_report_id"
  add_index "results", ["subject_id"], name: "index_results_on_subject_id"
  add_index "results", ["user_id"], name: "index_results_on_user_id"

  create_table "students", force: :cascade do |t|
    t.string   "firstname"
    t.string   "surname"
    t.date     "dob"
    t.boolean  "current",    default: true
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "students", ["user_id"], name: "index_students_on_user_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subjects", ["user_id"], name: "index_subjects_on_user_id"

  create_table "terms", force: :cascade do |t|
    t.string   "year"
    t.string   "term"
    t.date     "startdate"
    t.date     "enddate"
    t.boolean  "active",        default: true
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "term_group_id"
  end

  add_index "terms", ["term_group_id"], name: "index_terms_on_term_group_id"
  add_index "terms", ["user_id"], name: "index_terms_on_user_id"

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
    t.string   "schoolname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
