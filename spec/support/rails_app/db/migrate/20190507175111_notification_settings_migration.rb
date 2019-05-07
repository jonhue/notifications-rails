# frozen_string_literal: true

class NotificationSettingsMigration < ActiveRecord::Migration[5.2]
  # rubocop:disable Metrics/MethodLength
  def change
    add_column :notifications, :subscription_id, :bigint, index: true
    add_column :notifications, :category, :string, index: true

    create_table :notification_settings_settings do |t|
      t.references :object,
                   polymorphic: true,
                   index: { name: 'idx_settings_object_type_object_id' }
      t.references :subscription, index: true

      t.string :status

      t.text :settings
      t.text :category_settings

      t.timestamps
    end

    create_table :notification_settings_subscriptions do |t|
      t.references :subscriber,
                   polymorphic: true,
                   index: {
                     name: 'idx_subscriptions_subscriber_type_subscriber_id'
                   }
      t.references :subscribable,
                   polymorphic: true,
                   index: {
                     name: 'idx_subscriptions_subscribable_type_subscribable_id'
                   }

      t.timestamps
    end
  end
  # rubocop:enable Metrics/MethodLength
end
