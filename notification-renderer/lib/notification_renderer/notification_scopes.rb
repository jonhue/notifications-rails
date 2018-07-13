# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationRenderer
  module NotificationScopes
    extend ActiveSupport::Concern

    module ClassMethods
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
