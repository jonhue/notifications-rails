module NotificationPusher
    class OneSignal

        def initialize notification, options = {}
            if options[:player_ids].any?
                OneSignal::Notification.create params: {
                    app_id: options[:app_id],
                    url: options[:url] || notification.metadata[:onesignal_url],
                    contents: options[:contents] || notification.metadata[:onesignal_contents].to_h,
                    include_player_ids: options[:player_ids]
        		}, opts: { auth_key: options[:auth_key] }
            end
        end

    end
end
