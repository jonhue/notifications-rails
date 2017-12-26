module NotificationPusher
    module NotificationLibrary

        attr_accessor :push
        attr_accessor :push_options

        after_create_commit :initialize_pusher

        def push name, options = {}
            self.push = class_name
            self.push_options = options
            self.initialize_pusher
        end

        private

        def initialize_pusher
            unless self.push.nil?
                if self.push.kind_of(Array)
                    self.push.each do |class_name|
                        pusher = NotificationPusher::Pusher.find_by_name(class_name).last
                        if defined?(NotificationPusher.const_get(pusher.name))
                            options = pusher.options.merge! self.push_options[class_name.to_sym]
                            pusher.instances << NotificationPusher.const_get(pusher.name).new options
                        end
                    end
                else
                    pusher = NotificationPusher::Pusher.find_by_name(self.push).last
                    if defined?(NotificationPusher.const_get(pusher.name))
                        options = pusher.options.merge! self.push_options
                        pusher.instances << NotificationPusher.const_get(pusher.name).new self, options
                    end
                end
            end
        end

    end
end
