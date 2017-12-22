class Notification < ActiveRecord::Base

    extend NotificationHandler::Library
    extend NotificationHandler::Scopes

    belongs_to :target, polymorphic: true
    belongs_to :object, polymorphic: true

end
