# frozen_string_literal: true

FactoryBot.define do
  factory :sleep_log do
    association :user
    clock_in { DateTime.now.beginning_of_day + rand(23).hours }
  end
end
