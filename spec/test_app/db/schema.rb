# frozen_string_literal: true

ActiveRecord::Schema.define do
  # Set up any tables you need to exist for your test suite that don't belong
  # in migrations.

  create_table "notification_settings_settings", force: :cascade do |t|
    t.string "object_type"
    t.bigint "object_id"
    t.bigint "subscription_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "settings"
    t.text "category_settings"
    t.index ["category_settings"], name: "index_notification_settings_settings_on_category_settings"
    t.index ["object_type", "object_id"], name: "idx_settings_object_type_object_id"
    t.index ["settings"], name: "index_notification_settings_settings_on_settings"
    t.index ["subscription_id"], name: "index_notification_settings_settings_on_subscription_id"
  end

  create_table "notification_settings_subscriptions", force: :cascade do |t|
    t.string "subscriber_type"
    t.bigint "subscriber_id"
    t.string "subscribable_type"
    t.bigint "subscribable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscribable_type", "subscribable_id"], name: "idx_subscriptions_subscribable_type_subscribable_id"
    t.index ["subscriber_type", "subscriber_id"], name: "idx_subscriptions_subscriber_type_subscriber_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "target_type"
    t.bigint "target_id"
    t.string "object_type"
    t.bigint "object_id"
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
