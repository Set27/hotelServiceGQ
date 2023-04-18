# app/graphql/types/rating_enum.rb

module Types
  class RatingEnum < GraphQL::Schema::Enum
    value "STANDART"
    value "DELUXE"
    value "SUITE"
  end
end