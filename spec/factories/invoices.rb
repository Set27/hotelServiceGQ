FactoryBot.define do
  factory :invoice do
    request { nil }
    price { rand(1..500) }
  end
end
