# frozen_string_literal: true

require 'active_support'

module NotificationHandler
  module NotificationScopes
    extend ActiveSupport::Concern

    included do
      scope :read, -> { where(read: true) }
      scope :unread, -> { where(read: false) }

      if defined?(NotificationRenderer)
        include NotificationRenderer::NotificationScopes
      end
      if defined?(NotificationSettings)
        include NotificationSettings::NotificationScopes
      end
    end
  end
end
