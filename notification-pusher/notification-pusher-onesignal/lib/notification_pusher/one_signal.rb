# frozen_string_literal: true

require 'one_signal'

module NotificationPusher
  class OneSignal
    def initialize(notification, options = {})
      @notification = notification
      @options = options
    end

    def call
      return unless @options[:player_ids].any?

      ::OneSignal::Notification.create params: {
        app_id: @options[:app_id],
        url: url_param,
        contents: contents_param,
        headings: headings_param,
        subtitle: subtitle_param,
        include_player_ids: @options[:player_ids]
      }, opts: { auth_key: @options[:auth_key] }
    end

    private

    def url_param
      @options[:url]      || @notification.metadata[:onesignal_url].to_h
    end

    def contents_param
      @options[:contents] || @notification.metadata[:onesignal_contents].to_h
    end

    def headings_param
      @options[:headings] || @notification.metadata[:onesignal_headings].to_h
    end

    def subtitle_param
      @options[:subtitle] || @notification.metadata[:onesignal_subtitle].to_h
    end
  end
end
