# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    request { create(:request, user:) }
    price { rand(1..500) }
    created_at { Time.zone.now }

    transient do
      user { create(:user) }
    end
  end
end
