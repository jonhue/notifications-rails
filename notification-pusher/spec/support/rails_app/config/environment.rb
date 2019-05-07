# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

require_relative '../../../../../notification-handler/lib/notification-handler'
require_relative '../../../../lib/notification-pusher'

# Initialize the Rails application.
Rails.application.initialize!
