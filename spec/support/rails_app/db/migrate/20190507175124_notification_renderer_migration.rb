# frozen_string_literal: true

class NotificationRendererMigration < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :type, :string, index: true
  end
end
