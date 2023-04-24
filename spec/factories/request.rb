# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    price { rand(100..200) }
    capacity { rand(1..4) }
    user
    created_at { Time.zone.now }
  end
end
