# frozen_string_literal: true

require_relative '../../../../spec/spec_helper'
require_relative '../../../lib/notification_handler/configuration'
require_relative '../../../lib/notification_handler/group'

RSpec.describe NotificationHandler::Configuration do
  let(:configuration) { NotificationHandler.configuration }

  it 'allows configuring the gem' do
    NotificationHandler.configure do |config|
      config.define_group(:my_group, -> { where(subscribed: true) })
      config.cache = true
    end

    expect(configuration.groups[:my_group])
      .to eq NotificationHandler::Group.find_by_name!(:my_group)
    expect(configuration.cache).to be true
  end
end
