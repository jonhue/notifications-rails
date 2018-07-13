# frozen_string_literal: true

module NotificationHandler
  class Notification < ApplicationRecord
    include NotificationHandler::NotificationLibrary
    include NotificationHandler::NotificationScopes
  end
end
