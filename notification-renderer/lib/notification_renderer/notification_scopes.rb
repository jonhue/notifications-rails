# frozen_string_literal: true

require 'notification-handler'
require 'active_support'

module NotificationRenderer
  module NotificationScopes
    extend ActiveSupport::Concern

    module ClassMethods
      def method_missing(method, *args)
        if method.to_s[/(.+)_type/]
          where(type: $1.singularize.classify)
        else
          super
        end
      end

      # rubocop:disable Style/OptionalBooleanParameter
      def respond_to_missing?(method, include_private = false)
        super || method.to_s[/(.+)_type/]
      end
      # rubocop:enable Style/OptionalBooleanParameter
    end
  end
end
