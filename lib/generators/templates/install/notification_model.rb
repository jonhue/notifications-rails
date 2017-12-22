class Notification < ActiveRecord::Base

    extend NotificationsRails::NotificationLib
    extend NotificationsRails::NotificationScopes

    belongs_to :target, polymorphic: true
    belongs_to :object, polymorphic: true

end
