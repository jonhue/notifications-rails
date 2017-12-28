module NotificationHandler
    class Group

        attr_accessor :name
        attr_accessor :target_scope

        def initialize name, target_scope
            @name = name
            @target_scope = target_scope
        end

        def find_by_name name
            ObjectSpace.each_object(NotificationHandler::Group).select { |group| group.name == name.to_sym }
        end

    end
end
