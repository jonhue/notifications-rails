require 'notification-handler'
require 'active_support'

module NotificationPusher
    module NotificationLibrary

        extend ActiveSupport::Concern

        included do
            attr_accessor :pusher
            attr_accessor :pusher_options

            after_create_commit :initialize_pusher

            include NotificationPusher::NotificationLibrary::InstanceMethods
        end

        module InstanceMethods

            def push name, options = {}
                self.pusher = name
                self.pusher_options = options
                self.initialize_pusher
            end

            protected

            def initialize_pusher
                unless self.pusher.nil?
                    if self.pusher.kind_of?(Array)
                        self.pusher.each do |class_name|
                            pusher = NotificationPusher::Pusher.find_by_name(class_name).first
                            pusher.push(self, self.pusher_options[class_name.to_sym])
                        end
                    else
                        pusher = NotificationPusher::Pusher.find_by_name(self.pusher).first
                        pusher.push(self, self.pusher_options)
                    end
                end
            end

        end

    end
end
