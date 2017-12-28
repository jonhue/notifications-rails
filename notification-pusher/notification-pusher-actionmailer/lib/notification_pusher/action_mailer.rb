class NotificationPusher::ActionMailer

    require 'actionmailer/engine'

    def initialize notification, options = {}
        NotificationPusherActionmailerMailer.push notification, options
    end

end
