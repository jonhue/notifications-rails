# frozen_string_literal: true

NotificationHandler.configure do |config|
  # Cache amount of unread and read notifications for notification targets.
  # Learn more: https://github.com/jonhue/notifications-rails/tree/master/notification-handler#caching
  # config.cache = false

  # Groups are a powerful way to bulk-create notifications for multiple objects
  # that don't necessarily have a common class.
  # Learn more: https://github.com/jonhue/notifications-rails/tree/master/notification-handler#groups
  config.define_group :subscribers, -> { User.where(subscriber: true) }
  config.define_group :subscribed, lambda { |subscribed|
    User.where(subscriber: subscribed)
  }
  config.define_group :subscribed_and_starts_with,
                      lambda { |subscribed, starts_with|
                        User.where(subscriber: subscribed)
                            .where('name LIKE :prefix',
                                   prefix: "#{starts_with}%")
                      }
end
