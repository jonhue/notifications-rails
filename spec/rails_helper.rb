# frozen_string_literal: true

require 'bundler'
Bundler.require :default, :development

require 'spec_helper'

require 'active_record/connection_adapters/sqlite3_adapter'
ActiveRecord::ConnectionAdapters::SQLite3Adapter.represent_boolean_as_integer = true

# https://github.com/pat/combustion
Combustion.path = 'spec/test_app'
Combustion.initialize! :active_record

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
