# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    title { "Room #{Faker::Number.unique.number(digits: 3)}" }
    price { Faker::Number.between(from: 50, to: 200) }
    capacity { Faker::Number.between(from: 1, to: 6) }
    rating { %w[STANDART DELUXE SUITE].sample }
    is_occupied { false }
  end
end
