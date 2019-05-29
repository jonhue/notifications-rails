# frozen_string_literal: true

require_relative '../../../../spec/spec_helper'
require_relative '../../../lib/notification_pusher/configuration'
require_relative '../../../lib/notification_pusher/' \
                 'delivery_method_configuration'

module NotificationPusher
  module DeliveryMethod
    class CustomPusher < NotificationPusher::DeliveryMethod::Base
      def call; end
    end
  end
end

RSpec.describe NotificationPusher::Configuration do
  let(:configuration) { NotificationPusher.configuration }

  it 'allows configuring the gem' do
    NotificationPusher.configure do |config|
      config.register_delivery_method(:my_pusher, :CustomPusher)
    end

    expect(configuration.delivery_methods[:my_pusher])
      .to eq NotificationPusher::DeliveryMethodConfiguration
             .find_by_name!(:my_pusher)
  end
end
