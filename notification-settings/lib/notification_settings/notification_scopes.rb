module NotificationSettings
    module NotificationScopes

        def method_missing m, *args
            if m.to_s[/(.+)_category/]
                where category: $1.singularize.classify
            else
                super
            end
        end

        def respond_to? m, include_private = false
            super || m.to_s[/(.+)_category/]
        end

    end
end
