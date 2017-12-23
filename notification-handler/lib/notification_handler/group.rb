module NotificationHandler

    def self.define_group name, targets
        NotificationHandler::Group.new name: name.to_sym, targets: targets
    end

    class Group < ::Rails::Engine
        attr_accessor :name
        attr_accessor :targets

        def find_by_name name
            ObjectSpace.each_object(Group).select { |group| group.name == name.to_sym }
        end
    end

end
