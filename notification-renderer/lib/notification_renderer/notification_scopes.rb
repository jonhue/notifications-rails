module NotificationRenderer
    module NotificationScopes

        extend ActiveSupport::Concern

        included do
            include NotificationRenderer::NotificationScopes::InstanceMethods
        end

        module InstanceMethods

            def method_missing m, *args
                if m.to_s[/(.+)_type/]
                    where type: $1.singularize.classify
                else
                    super
                end
            end

            def respond_to? m, include_private = false
                super || m.to_s[/(.+)_type/]
            end

        end

    end
end
