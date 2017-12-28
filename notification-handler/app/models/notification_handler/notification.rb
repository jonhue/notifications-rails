class NotificationHandler::Notification < ApplicationRecord

    include NotificationHandler::NotificationLibrary
    include NotificationHandler::NotificationScopes

end
