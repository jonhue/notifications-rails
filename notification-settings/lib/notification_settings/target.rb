# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module Target
    extend ActiveSupport::Concern

    included do
      include NotificationSettings::Settings
      include NotificationSettings::Status
    end
  end
end
