# frozen_string_literal: true

require 'active_model'

module NotificationSettings
  class CategoryPreferencesForm
    include ActiveModel::Model

    NotificationSettings.configuration.categories.each do |category|
      attribute category, :boolean, default: true
    end
  end
end
