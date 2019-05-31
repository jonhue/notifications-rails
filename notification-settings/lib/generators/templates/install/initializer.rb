# frozen_string_literal: true

NotificationSettings.configure do |config|
  # An array of all notification categories. Takes an array of symbols.
  # config.categories = [:notification]

  # Choose your default notification category. Takes a symbol.
  # config.default_category = :notification

  ### STATUS ###

  # Time duration without activity after which the status defaults to `'idle'`.
  # Takes a time.
  # config.idle_after = 10.minutes

  # Time duration without activity after which the status defaults to
  # `'offline'`. Takes a time.
  # config.offline_after = 3.hours

  # Stringified datetime attribute name of `object` that defines the time of the
  # last activity. Takes a symbol.
  # config.last_seen = :last_seen

  # Array of all possible statuses. Takes an array of strings.
  # config.statuses = [
  #   'online',
  #   'idle',
  #   'offline',
  #   'do not notify',
  #   'do not disturb'
  # ]

  # Array of possible statuses that will prevent creating notifications for a
  # target. Takes an array of strings.
  # config.do_not_notify_statuses = ['do not notify']

  # Array of possible statuses that will prevent pushing notifications of a
  # target. Takes an array of strings.
  # config.do_not_deliver_statuses = ['do not disturb']
end
