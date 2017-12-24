module NotificationHandler
    class Group

        attr_accessor :name
        attr_accessor :target_scope

        def find_by_name name
            ObjectSpace.each_object(NotificationHandler::Group).select { |group| group.name == name.to_sym }
        end

    end
end
