# frozen_string_literal: true

require 'bundler'
Bundler.require :default, :development

# Why doesn't the Bundler.require automatically require this?
require 'notification-handler'

require 'spec_helper'
require_relative '../../spec/rails_helper.rb'
