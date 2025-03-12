# frozen_string_literal: true

require 'active_support'
require 'hashie'

module NotificationSettings
  module Settings
    extend ActiveSupport::Concern

    included do
      before_validation :build_settings

      if ActiveRecord.gem_version >= Gem::Version.new('7.0.0')
        serialize :settings, type: Hashie::Mash, coder: YAML
      else
        serialize :settings, Hashie::Mash
      end

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
