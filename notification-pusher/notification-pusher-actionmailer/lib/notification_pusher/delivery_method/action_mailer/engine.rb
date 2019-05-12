# frozen_string_literal: true

require 'rails/engine'
require 'action_mailer'

module NotificationPusher
  class ActionMailer
    class Engine < ::Rails::Engine
    end
  end
end
