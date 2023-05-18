# frozen_string_literal: true

module Types
  class RoomType < Types::BaseObject
    implements Types::BaseGlobalIdInterface

    field :title, String
    field :price, Integer
    field :capacity, Integer
    field :rating, Types::RatingEnum
    field :request, Types::RequestType, null: true
    field :is_occupied, Boolean
  end
end
