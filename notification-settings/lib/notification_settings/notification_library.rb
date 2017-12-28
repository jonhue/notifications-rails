require 'notification-handler'
require 'active_support'

module NotificationSettings
    module NotificationLibrary

        extend ActiveSupport::Concern

        included do
            before_create :validate_create
            belongs_to :subscription, class_name: 'NotificationSettings::Subscription', optional: true

            include NotificationSettings::NotificationLibrary::InstanceMethods
        end

        module InstanceMethods

            def category
                self[:category] || NotificationRenderer.configuration.default_category
            end

            private

            def validate_create
                valid = true

                if self.target.notification_setting.present?
                    # Status
                    valid = false if NotificationSettings.configuration.do_not_notify_statuses.include?(self.target.notification_setting.status)

                    # Settings
                    valid = false if !self.target.notification_setting.settings.dig(:enabled)
                    ## Category
                    valid = false if !self.target.notification_setting.category_settings.dig(self.category.to_sym, :enabled)
                end

                valid
            end

            def validate_push
                valid = true

                if self.target.notification_setting.present?
                    # Status
                    valid = false if NotificationSettings.configuration.do_not_push_statuses.include?(self.target.notification_setting.status)

                    # Settings
                    if self.push.kind_of?(Array)
                        self.push.each do |pusher|
                            valid = false if !self.target.notification_setting.settings.dig(pusher.to_sym) || ( !self.target.notification_setting.settings.dig(:index) && self.target.notification_setting.settings.dig(pusher.to_sym).nil? )
                            ## Category
                            valid = false if !self.target.notification_setting.category_settings.dig(self.category.to_sym, pusher.to_sym) || ( !self.target.notification_setting.category_settings.dig(self.category.to_sym, :index) && self.target.notification_setting.category_settings.dig(self.category.to_sym, pusher.to_sym).nil? )
                        end
                    else
                        valid = false if !self.target.notification_setting.settings.dig(self.push.to_sym) || ( !self.target.notification_setting.settings.dig(:index) && self.target.notification_setting.settings.dig(self.push.to_sym).nil? )
                        ## Category
                        valid = false if !self.target.notification_setting.category_settings.dig(self.category.to_sym, self.push.to_sym) || ( !self.target.notification_setting.category_settings.dig(self.category.to_sym, :index) && self.target.notification_setting.category_settings.dig(self.category.to_sym, self.push.to_sym).nil? )
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
end
