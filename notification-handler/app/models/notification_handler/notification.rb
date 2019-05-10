# frozen_string_literal: true

module NotificationHandler
  class Notification < ApplicationRecord
    include NotificationHandler::NotificationLib
    include NotificationHandler::NotificationScopes
  end
end
