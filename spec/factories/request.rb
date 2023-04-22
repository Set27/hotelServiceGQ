FactoryBot.define do
  factory :request do
    price {rand(100..200)}
    capacity {rand(1..4)}
    user
  end
end