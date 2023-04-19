module Types
  class RoomType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :price, Integer, null: true
    field :capacity, Integer, null: true
    field :rating, Types::RatingEnum, null: true
    field :is_occupied, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end