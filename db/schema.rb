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

ActiveRecord::Schema[7.1].define(version: 2026_11_27_080100) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.string "subcategory"
    t.text "content"
    t.string "slug"
    t.boolean "published", default: false
    t.integer "view_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0, null: false
    t.string "summary"
    t.string "seed_digest"
    t.index ["category", "subcategory", "position"], name: "index_articles_on_category_and_subcategory_and_position"
    t.index ["category"], name: "index_articles_on_category"
    t.index ["published"], name: "index_articles_on_published"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
  end

  create_table "audit_events", force: :cascade do |t|
    t.integer "user_id"
    t.string "actor_email"
    t.string "action", null: false
    t.string "target_type"
    t.bigint "target_id"
    t.string "target_label"
    t.text "details"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_audit_events_on_created_at"
    t.index ["target_type", "target_id"], name: "index_audit_events_on_target_type_and_target_id"
    t.index ["user_id"], name: "index_audit_events_on_user_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "article_id"
    t.text "last_position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.index ["article_id"], name: "index_bookmarks_on_article_id"
    t.index ["session_id"], name: "index_bookmarks_on_session_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "case_studies", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "content"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer "user_id"
    t.text "message", null: false
    t.string "role", null: false
    t.string "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_chat_messages_on_role"
    t.index ["session_id"], name: "index_chat_messages_on_session_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "updates", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "published_at"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "role", default: "pengguna", null: false
    t.string "status", default: "pending", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["status"], name: "index_users_on_status"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "audit_events", "users", on_delete: :nullify
  add_foreign_key "chat_messages", "users"
end
