class NotificationHandler::Notification < ActiveRecord::Base

    extend NotificationHandler::NotificationLibrary
    extend NotificationHandler::NotificationScopes

    serialize :metadata, Hash

    belongs_to :target, polymorphic: true
    belongs_to :object, polymorphic: true, optional: true

end
