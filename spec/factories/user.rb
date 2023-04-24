# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    role { "USER" }
    email { Faker::Internet.email(name:) }
    password { "password123" }

    factory :admin do
      role { "ADMIN" }
    end
  end
end
