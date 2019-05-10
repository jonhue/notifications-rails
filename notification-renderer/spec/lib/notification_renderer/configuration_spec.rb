# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/notification_renderer/configuration'

RSpec.describe NotificationRenderer::Configuration do
  let(:config) { NotificationRenderer.configuration }

  it 'allows configuring the gem' do
    NotificationRenderer.configure do |config|
      config.default_type     = 'message'
      config.default_renderer = 'admin'
      config.auto_read        = false
    end

    expect(config.default_type).to     eq 'message'
    expect(config.default_renderer).to eq 'admin'
    expect(config.auto_read).to        eq false
  end
end
