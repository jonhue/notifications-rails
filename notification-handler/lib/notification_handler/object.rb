# frozen_string_literal: true

module NotificationHandler
  module Object
    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods
      def notification_object
        has_many :belonging_notifications, as: :object, class_name: 'Notification', dependent: :destroy
        include NotificationHandler::Object::InstanceMethods

        include NotificationSettings::Subscribable if defined?(NotificationSettings)
      end
    end

    module InstanceMethods
      # ...
    end
  end
end
