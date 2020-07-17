# frozen_string_literal: true

require 'rails/all'

require 'factory_bot'
require 'rspec/rails'

ENV['RAILS_ENV'] = 'test'
require_relative 'support/rails_app/config/environment'

ActiveRecord::Migration.maintain_test_schema!
ActiveRecord::Schema.verbose = false
require_relative 'support/rails_app/db/schema'

require_relative '../../spec/spec_helper'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before :suite do
    require_relative 'factories/notifications'
    require_relative 'factories/users'
  end
end
