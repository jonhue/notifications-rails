# frozen_string_literal: true

module NotificationPusher
  class ActionMailer
    class NotificationMailer < ApplicationMailer
      # rubocop:disable Metrics/ParameterLists
      def push(notification,
               from:, to: nil, renderer: 'actionmailer', layout: nil,
               mail_options: {})
        render(layout: layout) unless layout.nil?

        @notification = notification
        @renderer = renderer

        mail({
          to: to || notification.target.email,
          from: from
        }.merge(mail_options))
      end
      # rubocop:enable Metrics/ParameterLists
    end
  end
end
