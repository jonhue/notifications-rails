# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/notification_handler/configuration'
require_relative '../../../lib/notification_handler/group'

RSpec.describe NotificationHandler::Configuration do
  let(:config) { NotificationHandler.configuration }

  it 'allows configuring the gem' do
    NotificationHandler.configure do |config|
      config.define_group(:my_group, -> { where(subscribed: true) })
      config.cache  = true
    end

    expect(config.groups).to include NotificationHandler::Group.find_by_name!(:my_group)
    expect(config.cache).to  eq true
  end
end
