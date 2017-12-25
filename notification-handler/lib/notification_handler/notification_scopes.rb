module NotificationHandler
    module NotificationScopes

        scope :read, -> { where(read: true) }
        scope :unread, -> { where(read: false) }

    end
end
