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

ActiveRecord::Schema.define(version: 2019_05_07_175111) do

  create_table "notification_settings_settings", force: :cascade do |t|
    t.string "object_type"
    t.integer "object_id"
    t.integer "subscription_id"
    t.string "status"
    t.text "settings"
    t.text "category_settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "idx_settings_object_type_object_id"
    t.index ["subscription_id"], name: "index_notification_settings_settings_on_subscription_id"
  end

  create_table "notification_settings_subscriptions", force: :cascade do |t|
    t.string "subscriber_type"
    t.integer "subscriber_id"
    t.string "subscribable_type"
    t.integer "subscribable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscribable_type", "subscribable_id"], name: "idx_subscriptions_subscribable_type_subscribable_id"
    t.index ["subscriber_type", "subscriber_id"], name: "idx_subscriptions_subscriber_type_subscriber_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "target_type"
    t.integer "target_id"
    t.string "object_type"
    t.integer "object_id"
    t.boolean "read", default: false, null: false
    t.text "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subscription_id"
    t.string "category"
    t.index ["object_type", "object_id"], name: "index_notifications_on_object_type_and_object_id"
    t.index ["read"], name: "index_notifications_on_read"
    t.index ["target_type", "target_id"], name: "index_notifications_on_target_type_and_target_id"
  end

end
