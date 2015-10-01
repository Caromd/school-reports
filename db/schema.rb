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

ActiveRecord::Schema.define(version: 20151001111940) do

  create_table "grades", force: :cascade do |t|
    t.string   "grade"
    t.string   "year"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "grades", ["student_id"], name: "index_grades_on_student_id"

  create_table "reports", force: :cascade do |t|
    t.string   "teacher"
    t.text     "teacher_comment"
    t.string   "principal"
    t.text     "principal_comment"
    t.integer  "student_id"
    t.integer  "term_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "reports", ["student_id"], name: "index_reports_on_student_id"
  add_index "reports", ["term_id"], name: "index_reports_on_term_id"

  create_table "results", force: :cascade do |t|
    t.decimal  "classmark"
    t.decimal  "testmark"
    t.integer  "student_id"
    t.integer  "subject_id"
    t.integer  "term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "comment"
  end

  add_index "results", ["student_id"], name: "index_results_on_student_id"
  add_index "results", ["subject_id"], name: "index_results_on_subject_id"
  add_index "results", ["term_id"], name: "index_results_on_term_id"

  create_table "students", force: :cascade do |t|
    t.string   "firstname"
    t.string   "surname"
    t.date     "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.string   "year"
    t.string   "term"
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
