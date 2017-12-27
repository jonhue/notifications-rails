class NotificationHandler::Notification < ActiveRecord::Base

    extend NotificationHandler::NotificationLibrary
    extend NotificationRenderer::NotificationLibrary if defined?(NotificationRenderer)
    extend NotificationPusher::NotificationLibrary if defined?(NotificationPusher)
    extend NotificationSettings::NotificationLibrary if defined?(NotificationSettings)
    extend NotificationHandler::NotificationScopes
    extend NotificationRenderer::NotificationScopes if defined?(NotificationRenderer)
    extend NotificationSettings::NotificationScopes if defined?(NotificationSettings)

    serialize :metadata, Hash

    belongs_to :target, polymorphic: true
    belongs_to :object, polymorphic: true, optional: true

end
