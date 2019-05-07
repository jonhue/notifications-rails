# frozen_string_literal: true

# rubocop:disable Lint/UnneededCopDisableDirective
# rubocop:disable RSpec/ContextWording

RSpec.shared_context 'general shared context' do
  def build_notification(**options)
    Notification.new(   target: user, **options)
  end

  def create_notification(**options)
    Notification.create(target: user, **options)
  end

  let(:user) { User.create! }
  let(:notification) { create_notification }
end

RSpec.configure do |config|
  config.include_context 'general shared context'
end

# rubocop:enable RSpec/ContextWording
# rubocop:enable Lint/UnneededCopDisableDirective
