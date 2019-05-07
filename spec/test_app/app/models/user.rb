# frozen_string_literal: true

class User < ApplicationRecord
  notification_target

  scope :subscribers, -> { User.where(subscriber: true) }
end
