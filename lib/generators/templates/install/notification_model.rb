class Notification < ActiveRecord::Base

    extend NotificationsRails::Handler::NotificationLib
    extend NotificationsRails::Handler::NotificationScopes

    belongs_to :target, polymorphic: true
    belongs_to :object, polymorphic: true

end
