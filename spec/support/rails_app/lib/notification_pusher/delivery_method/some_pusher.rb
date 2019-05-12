# frozen_string_literal: true

module NotificationPusher
  module DeliveryMethod
    class SomePusher < NotificationPusher::DeliveryMethod::Base
      def call; end
    end
  end
end
