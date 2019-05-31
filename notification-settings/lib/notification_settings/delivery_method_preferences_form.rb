# frozen_string_literal: true

require 'active_model'

module NotificationSettings
  class DeliveryMethodPreferencesForm
    include ActiveModel::Model

    attribute :enabled, :boolean, default: true
    NotificationPusher.configuration.delivery_methods
                      .each do |delivery_method, _|
      attribute delivery_method, :boolean, default: true
    end
  end
end
