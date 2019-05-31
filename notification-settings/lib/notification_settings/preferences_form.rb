# frozen_string_literal: true

require 'active_model'

module NotificationSettings
  class PreferencesForm
    include ActiveModel::Model

    attribute :enabled, :boolean, default: true
  end
end
