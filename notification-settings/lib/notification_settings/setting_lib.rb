# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module SettingLib
    extend ActiveSupport::Concern

    included do
      include NotificationSettings::SettingLib::InstanceMethods
    end

    module InstanceMethods
      def status
        if idle? && !offline?
          default = 'idle'
        elsif offline?
          default = 'offline'
        else
          'online'
        end
        self[:status] || default
      end

      private

      def idle?
        return unless time_since_last_seen_round

        time_since_last_seen_round >= idle_after
      end

      def offline?
        return unless time_since_last_seen_round

        time_since_last_seen_round >= offline_after
      end

      def time_since_last_seen_round
        time_since_last_seen&.round
      end

      def time_since_last_seen
        return unless object.respond_to?(
          NotificationSettings.configuration.last_seen
        )

        Time.now - object.send(NotificationSettings.configuration.last_seen)
      end

      def idle_after
        NotificationSettings.configuration.idle_after
      end

      def offline_after
        NotificationSettings.configuration.offline_after
      end
    end
  end
end
