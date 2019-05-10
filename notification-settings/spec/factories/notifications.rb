# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    target { build_stubbed :user }
    category { :default_category }
  end
end
