# frozen_string_literal: true

require 'active_support'

module NotificationSettings
  module Status
    extend ActiveSupport::Concern

    included do
      validates :status,
                inclusion: { in: NotificationSettings.configuration.statuses }

      include NotificationSettings::Status::InstanceMethods
    end

    module InstanceMethods
      def status
        self[:status] || default_status
      end

      private

      def default_status
        if idle? && !offline?
          'idle'
        elsif offline?
          'offline'
        else
          'online'
        end
      end

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
        return unless respond_to?(NotificationSettings.configuration.last_seen)

        Time.now - send(NotificationSettings.configuration.last_seen)
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
