# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_14_184138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.jsonb "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.integer "lesson_part_id", null: false
    t.text "overview"
    t.text "guidance"
    t.integer "duration", null: false
    t.string "extra_requirements", limit: 32, array: true
    t.string "name", limit: 128, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_part_id"], name: "index_activities_on_lesson_part_id"
  end

  create_table "activity_choices", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "activity_id", null: false
    t.bigint "lesson_part_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_activity_choices_on_activity_id"
    t.index ["lesson_part_id"], name: "index_activity_choices_on_lesson_part_id"
    t.index ["teacher_id", "lesson_part_id"], name: "index_activity_choices_on_teacher_id_and_lesson_part_id", unique: true
    t.index ["teacher_id"], name: "index_activity_choices_on_teacher_id"
  end

  create_table "activity_teaching_methods", force: :cascade do |t|
    t.integer "teaching_method_id", null: false
    t.integer "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_activity_teaching_methods_on_activity_id"
    t.index ["teaching_method_id", "activity_id"], name: "index_activity_teaching_methods_teaching_method_id_activity_id", unique: true
  end

  create_table "complete_curriculum_programmes", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.text "rationale", null: false
    t.text "guidance", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "key_stage", null: false
    t.index ["name"], name: "index_complete_curriculum_programmes_on_name"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "download_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.jsonb "metadata", default: {}
    t.integer "sort_key", null: false
    t.integer "download_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["download_id", "most_recent"], name: "index_download_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["download_id", "sort_key"], name: "index_download_transitions_parent_sort", unique: true
  end

  create_table "downloads", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_downloads_on_lesson_id"
    t.index ["teacher_id"], name: "index_downloads_on_teacher_id"
  end

  create_table "lesson_parts", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "default_activity_id"
    t.index ["default_activity_id"], name: "index_lesson_parts_on_default_activity_id"
    t.index ["lesson_id"], name: "index_lesson_parts_on_lesson_id"
    t.index ["position", "lesson_id"], name: "index_lesson_parts_on_position_and_lesson_id", unique: true
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "unit_id", null: false
    t.string "name", limit: 128, null: false
    t.string "learning_objective", limit: 256, null: false
    t.integer "position", null: false
    t.text "core_knowledge_for_teachers"
    t.text "core_knowledge_for_pupils"
    t.text "previous_knowledge"
    t.text "vocabulary"
    t.text "misconceptions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_lessons_on_name"
    t.index ["unit_id"], name: "index_lessons_on_unit_id"
  end

  create_table "resources", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_resources_on_activity_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.string "token", limit: 24
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_suppliers_on_name", unique: true
    t.index ["token"], name: "index_suppliers_on_token", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.uuid "token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_teachers_on_token", unique: true
  end

  create_table "teaching_methods", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.text "description"
    t.string "icon", limit: 64
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer "complete_curriculum_programme_id"
    t.string "name", limit: 128, null: false
    t.string "summary", limit: 1024, null: false
    t.text "rationale", null: false
    t.text "guidance", null: false
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "year", null: false
    t.index ["complete_curriculum_programme_id"], name: "index_units_on_complete_curriculum_programme_id"
    t.index ["name"], name: "index_units_on_name"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "lesson_parts"
  add_foreign_key "activity_choices", "activities"
  add_foreign_key "activity_choices", "lesson_parts"
  add_foreign_key "activity_choices", "teachers"
  add_foreign_key "activity_teaching_methods", "activities"
  add_foreign_key "activity_teaching_methods", "teaching_methods"
  add_foreign_key "complete_curriculum_programmes", "subjects"
  add_foreign_key "download_transitions", "downloads"
  add_foreign_key "downloads", "lessons"
  add_foreign_key "downloads", "teachers"
  add_foreign_key "lesson_parts", "activities", column: "default_activity_id"
  add_foreign_key "lesson_parts", "lessons"
  add_foreign_key "lessons", "units"
  add_foreign_key "resources", "activities"
  add_foreign_key "units", "complete_curriculum_programmes"
end
