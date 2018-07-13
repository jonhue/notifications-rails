# frozen_string_literal: true

module NotificationPusher
  class ActionMailer
    class NotificationMailer < ApplicationMailer
      def push(notification,
               from:, to: nil, renderer: 'actionmailer', layout: nil)
        render(layout: layout) unless layout.nil?
        @notification = notification
        @renderer = renderer
        mail(to: to || notification.target.email, from: from)
      end
    end
  end
end
