# frozen_string_literal: true

require_relative '../../../../spec/spec_helper'
require_relative '../../../lib/notification_renderer/configuration'

RSpec.describe NotificationRenderer::Configuration do
  let(:configuration) { NotificationRenderer.configuration }

  it 'allows configuring the gem' do
    NotificationRenderer.configure do |config|
      config.default_type     = 'message'
      config.default_renderer = 'admin'
      config.auto_read        = false
    end

    expect(configuration.default_type).to     eq 'message'
    expect(configuration.default_renderer).to eq 'admin'
    expect(configuration.auto_read).to        be false
  end
end
