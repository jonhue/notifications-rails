module NotificationPusher
    class ActionMailer

        require 'action_mailer/engine'

        def initialize notification, options = {}
            NotificationPusherActionmailerMailer.push notification, options
        end

    end
end
