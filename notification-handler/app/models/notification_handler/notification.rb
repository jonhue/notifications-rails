# frozen_string_literal: true

class NotificationHandler::Notification < ApplicationRecord
  include NotificationHandler::NotificationLibrary
  include NotificationHandler::NotificationScopes
end
