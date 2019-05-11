# frozen_string_literal: true

module NotificationPusher
  module DeliveryMethod
    class Null
      def call; end
    end
  end
end
