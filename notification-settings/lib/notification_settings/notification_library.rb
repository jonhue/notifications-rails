module NotificationSettings
    module NotificationLibrary

        before_create :validate_create

        private

        def validate_create
            valid = true
            
            if self.target.notification_setting.present?
                # Status
                valid = false if NotificationSettings.configuration.do_not_notify_statuses.include?(self.target.notification_setting.status)
                # Category
                valid = false if !self.target.notification_setting.settings.dig(:enabled) || self.target.notification_setting.settings.dig(self.category.to_sym, :enabled)
            end
            
            valid
        end

        def validate_push
            valid = true
            
            if self.target.notification_setting.present?
                # Status
                valid = false if NotificationSettings.configuration.do_not_push_statuses.include?(self.target.notification_setting.status)
                # Category & Pusher
                if self.push.kind_of?(Array)
                    self.push.each do |pusher|
                        valid = false if !self.target.notification_setting.settings.dig(pusher.to_sym) || self.target.notification_setting.settings.dig(self.category.to_sym, pusher.to_sym) || ( !self.target.notification_setting.settings.dig(:index) && self.target.notification_setting.settings.dig(pusher.to_sym).nil? ) || ( !self.target.notification_setting.settings.dig(self.category.to_sym, :index) && self.target.notification_setting.settings.dig(self.category.to_sym, pusher.to_sym).nil? )
                    end
                else
                    valid = false if !self.target.notification_setting.settings.dig(self.push.to_sym) || self.target.notification_setting.settings.dig(self.category.to_sym, self.push.to_sym) || ( !self.target.notification_setting.settings.dig(:index) && self.target.notification_setting.settings.dig(self.push.to_sym).nil? ) || ( !self.target.notification_setting.settings.dig(self.category.to_sym, :index) && self.target.notification_setting.settings.dig(self.category.to_sym, self.push.to_sym).nil? )
                end
            end
            
            valid
        end

        def initialize_pusher
            return unless validate_push
            super
        end

    end
end
