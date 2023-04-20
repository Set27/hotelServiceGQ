FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    role { "USER" }
    email { Faker::Internet.email(name: name) }
    password { "password123" }

    factory :admin do
      role {"ADMIN"}
    end

    # trait :admin do
    #   role { "ADMIN" }
    # end

  end
end