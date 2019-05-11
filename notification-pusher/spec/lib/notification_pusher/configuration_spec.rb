# frozen_string_literal: true

require_relative '../../../../spec/spec_helper'
require_relative '../../../lib/notification_pusher/configuration'
require_relative '../../../lib/notification_pusher/delivery_method_configuration'

RSpec.describe NotificationPusher::Configuration do
  let(:configuration) { NotificationPusher.configuration }

  it 'allows configuring the gem' do
    NotificationPusher.configure do |config|
      config.register_delivery_method(:my_pusher)
    end

    expect(configuration.delivery_methods)
      .to include NotificationPusher::DeliveryMethodConfiguration.find_by_name!(:my_pusher)
  end
end
