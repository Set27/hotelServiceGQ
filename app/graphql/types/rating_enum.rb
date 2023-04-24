# frozen_string_literal: true

module Types
  class RatingEnum < GraphQL::Schema::Enum
    value 'STANDART'
    value 'DELUXE'
    value 'SUITE'
  end
end
