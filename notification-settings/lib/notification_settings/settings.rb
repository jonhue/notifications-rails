# frozen_string_literal: true

require 'active_support'
require 'hashie'

module NotificationSettings
  module Settings
    extend ActiveSupport::Concern

    included do
      before_validation :build_settings

      serialize :settings, Hashie::Mash

      include NotificationSettings::Settings::InstanceMethods
    end

    module InstanceMethods
      private

      def build_settings
        return if settings.present? && settings.is_a?(Hashie::Mash)

        self.settings = Hashie::Mash.new
      end
    end
  end
end
