# frozen_string_literal: true

module Types
  class RoomOccupiedEnum < GraphQL::Schema::Enum
    value "FREE"
    value "ALL"
  end
end
