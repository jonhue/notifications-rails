# frozen_string_literal: true

require 'rails/railtie'
require 'action_mailer'

module NotificationPusher
  class ActionMailer
    class Engine < ::Rails::Engine
    end
  end
end
