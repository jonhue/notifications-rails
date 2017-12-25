NotificationHandler.configure do |config|

    # Cache amount of unread and read notifications for notification targets
    # Learn more: https://github.com/jonhue/notifications-rails/tree/master/notification-handler#caching
    # config.cache = false

    # Groups are a powerful way to bulk-create notifications for multiple objects that don't necessarily have a common class.
    # Learn more: https://github.com/jonhue/notifications-rails/tree/master/notification-handler#groups
    # config.define_group :subscribers, User.where(subscriber: true)

end
