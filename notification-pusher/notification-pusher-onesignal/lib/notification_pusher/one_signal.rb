# frozen_string_literal: true

require 'one_signal'

module NotificationPusher
  class OneSignal
    def initialize(notification,
                   app_id:, auth_key:, player_ids:, url: nil, contents: nil,
                   headings: nil, subtitle: nil)
      return unless options[:player_ids].any?
      ::OneSignal::Notification.create(
        params: {
          app_id: app_id,
          url: url_param(url, notification),
          contents: contents_param(contents, notification),
          headings: headings_param(headings, notification),
          subtitle: subtitle_param(subtitle, notification),
          include_player_ids: player_ids
        }, opts: { auth_key: auth_key }
      )
    end

    private

    def url_param(url, notification)
      url || notification.metadata[:onesignal_url].to_h
    end

    def contents_param(contents, notification)
      contents || notification.metadata[:onesignal_contents].to_h
    end

    def headings_param(headings, notification)
      headings || notification.metadata[:onesignal_headings].to_h
    end

    def subtitle_param(subtitle, notification)
      subtitle || notification.metadata[:onesignal_subtitle].to_h
    end
  end
end
