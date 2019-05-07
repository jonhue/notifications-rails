# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

require_relative '../../../../notification-handler/lib/notification-handler'
require_relative '../../../../notification-pusher/lib/notification-pusher'
require_relative '../../../../notification-renderer/lib/notification-renderer'
require_relative '../../../../notification-settings/lib/notification-settings'

# Initialize the Rails application.
Rails.application.initialize!
