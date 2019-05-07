# frozen_string_literal: true

module NotificationPusher
  class Null
    def initialize(_notification, _options = {}); end

    def call; end
  end
end
