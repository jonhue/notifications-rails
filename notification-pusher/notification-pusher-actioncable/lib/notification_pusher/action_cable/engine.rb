# frozen_string_literal: true

require 'rails/railtie'
require 'action_cable'

module NotificationPusher
  class ActionCable
    class Engine < ::Rails::Engine
    end
  end
end
