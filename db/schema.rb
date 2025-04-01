# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_26_144056) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "uuid-ossp"

  create_table "action_mailbox_inbound_emails", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "action_text_rich_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "builds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "launch_id", null: false
    t.uuid "resource_id", null: false
    t.uuid "lti_provider_user_id", null: false
    t.jsonb "test_output", default: "{}", null: false
    t.text "commit_sha"
    t.citext "username"
    t.text "reponame"
    t.text "source"
    t.float "score"
    t.integer "attempt_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["launch_id"], name: "index_builds_on_launch_id"
    t.index ["lti_provider_user_id"], name: "index_builds_on_lti_provider_user_id"
    t.index ["resource_id", "lti_provider_user_id", "attempt_number"], name: "idx_on_resource_id_lti_provider_user_id_attempt_num_04d6705cd7", unique: true
    t.index ["resource_id"], name: "index_builds_on_resource_id"
  end

  create_table "lti_provider_launches", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "canvas_url"
    t.string "nonce"
    t.jsonb "provider_params", default: "{}", null: false
    t.string "submission_token"
    t.uuid "resource_id"
    t.uuid "lti_provider_user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "lti_provider_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "canvas_user_id"
    t.text "lis_person_name_full"
    t.text "lis_user_id"
    t.citext "lis_person_contact_email_primary"
    t.text "user_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canvas_user_id"], name: "index_lti_provider_users_on_canvas_user_id"
    t.index ["lis_user_id"], name: "index_lti_provider_users_on_lis_user_id"
  end

  create_table "resources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "context_id", null: false
    t.string "resource_link_id", null: false
    t.string "project_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_id", "resource_link_id"], name: "index_resources_on_context_id_and_resource_link_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "builds", "lti_provider_launches", column: "launch_id"
  add_foreign_key "builds", "lti_provider_users"
  add_foreign_key "builds", "resources"
end
