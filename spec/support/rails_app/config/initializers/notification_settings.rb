# frozen_string_literal: true

NotificationSettings.configure do |config|
  # Choose your default notification category. Takes a string.
  # config.default_category = 'notification'

  ### STATUS ###

  # Time duration without activity after which the status defaults to `'idle'`.
  # Takes a time.
  # config.idle_after = 10.minutes

  # Time duration without activity after which the status defaults to
  # `'offline'`. Takes a time.
  # config.offline_after = 3.hours

  # Stringified datetime attribute name of `object` that defines the time of the
  # last activity. Takes a string.
  # config.last_seen = 'last_seen'

  # Array of possible statuses that will prevent creating notifications for a
  # target. Takes an array of strings.
  # config.do_not_notify_statuses = []

  # Array of possible statuses that will prevent pushing notifications of a
  # target. Takes an array of strings.
  # config.do_not_deliver_statuses = ['do not disturb']
end
