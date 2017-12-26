module NotificationSettings
    module NotificationLibrary

        before_create :validate_status

        private

        def validate_status_create
            self.target.notification_setting.present? && NotificationSettings.configuration.do_not_notify_statuses.include?(self.target.notification_setting.status) ? false : true
        end

        def validate_status_push
            self.target.notification_setting.present? && NotificationSettings.configuration.do_not_push_statuses.include?(self.target.notification_setting.status) ? false : true
        end

        def initialize_pusher
            return unless validate_status_push
            super
        end

    end
end
