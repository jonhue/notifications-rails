# frozen_string_literal: true

require_relative '../../../../spec/spec_helper'
require_relative '../../../lib/notification_settings/configuration'

RSpec.describe NotificationSettings::Configuration do
  let(:configuration) { NotificationSettings.configuration }

  it 'allows configuring the gem' do
    NotificationSettings.configure do |config|
      config.default_category        = :my_category
      config.last_seen               = :last_activity
      config.idle_after              = 30.minutes
      config.offline_after           = 6.hours
      config.do_not_notify_statuses  = ['do not disturb']
      config.do_not_deliver_statuses = ['do not disturb', 'focus']
    end

    expect(configuration.default_category).to       eq :my_category
    expect(configuration.last_seen).to              eq :last_activity
    expect(configuration.idle_after).to             eq 30.minutes
    expect(configuration.offline_after).to          eq 6.hours
    expect(configuration.do_not_notify_statuses).to eq ['do not disturb']
    expect(configuration.do_not_deliver_statuses)
      .to eq ['do not disturb', 'focus']
  end
end
