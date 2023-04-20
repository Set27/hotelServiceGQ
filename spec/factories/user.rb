FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    role { "ADMIN" }
    email { Faker::Internet.email(name: name) }
    password { "password123" }

    # trait :admin do
    #   role { "ADMIN" }
    # end

  end
end