# frozen_string_literal: true

class NotificationPusher::ActionMailer::NotificationMailer < ApplicationMailer
  def push notification, options = {}
    render(layout: options[:layout]) if options.has_key?(:layout)
    @notification = notification
    @renderer = options[:renderer] || 'actionmailer'
    mail to: options[:to] || notification.target.email, from: options[:from]
  end
end
