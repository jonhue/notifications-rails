module NotificationPusher
    module NotificationLibrary

        extend ActiveSupport::Concern

        included do
            attr_accessor :push
            attr_accessor :push_options

            after_create_commit :initialize_pusher

            include NotificationPusher::NotificationLibrary::InstanceMethods
        end

        module InstanceMethods

            def push name, options = {}
                self.push = class_name
                self.push_options = options
                self.initialize_pusher
            end

            private

            def initialize_pusher
                unless self.push.nil?
                    if self.push.kind_of?(Array)
                        self.push.each do |class_name|
                            pusher = NotificationPusher::Pusher.find_by_name(class_name).first
                            if defined?(NotificationPusher.const_get(pusher.name))
                                default_options = pusher.options
                                options = default_options.merge! self.push_options[class_name.to_sym]
                                # instance = NotificationPusher.const_get(pusher.name).new self, options
                                # pusher.instances << instance
                            end
                        end
                    else
                        pusher = NotificationPusher::Pusher.find_by_name(self.push).first
                        if defined?(NotificationPusher.const_get(pusher.name))
                            default_options = pusher.options
                            options = default_options.merge! self.push_options
                            # instance = NotificationPusher.const_get(pusher.name).new self, options
                            # pusher.instances << instance
                        end
                    end
                end
            end

        end

    end
end
