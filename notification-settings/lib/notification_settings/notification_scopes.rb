# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationSettings
  module NotificationScopes
    extend ActiveSupport::Concern

    included do
      include NotificationSettings::NotificationScopes::InstanceMethods
    end

    module InstanceMethods
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
end
