# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/notification_pusher/configuration'
require_relative '../../../lib/notification_pusher/pusher'

RSpec.describe NotificationPusher::Configuration do
  let(:config) { NotificationPusher.configuration }

  it 'allows configuring the gem' do
    NotificationPusher.configure do |config|
      config.define_pusher(:my_pusher)
    end

    expect(config.pushers).to include NotificationPusher::Pusher.find_by_name!(:my_pusher)
  end
end
