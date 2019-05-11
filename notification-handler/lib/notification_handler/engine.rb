# frozen_string_literal: true

require 'rails/engine'
require 'active_record'

module NotificationHandler
  class Engine < ::Rails::Engine
    initializer 'notification-handler.active_record' do
      ActiveSupport.on_load :active_record do
        include NotificationHandler::Target
        include NotificationHandler::Object
      end
    end
  end
end
