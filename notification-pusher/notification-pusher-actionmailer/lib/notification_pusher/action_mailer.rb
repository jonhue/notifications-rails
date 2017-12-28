module NotificationPusher
    class ActionMailer

        require 'action_mailer'

        def initialize notification, options = {}
            NotificationPusherActionmailerMailer.push notification, options
        end

    end
end
