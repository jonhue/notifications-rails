# frozen_string_literal: true

require 'active_model'

module NotificationSettings
  class DeliveryMethodPreferencesForm
    include ActiveModel::Model

    attribute :enabled, :boolean, default: true
    NotificationPusher.configuration.delivery_methods
                      .each_key do |delivery_method|
      attribute delivery_method, :boolean, default: true
    end
  end
end
