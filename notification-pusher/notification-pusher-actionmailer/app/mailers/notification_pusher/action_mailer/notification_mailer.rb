class NotificationPusher::ActionMailer::NotificationMailer < ApplicationMailer

    def push notification, options = {}
        @notification = notification
        @renderer = options[:renderer] || 'actionmailer'
        mail to: options[:to] || notification.target.email, from: options[:from]
    end

end
