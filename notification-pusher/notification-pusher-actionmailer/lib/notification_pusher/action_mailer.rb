require 'notification-renderer'

class NotificationPusher::ActionMailer

    require 'notification_pusher/action_mailer/engine'

    def initialize notification, options = {}
        ::NotificationPusher::ActionMailer::NotificationMailer.push notification, options
    end

end
