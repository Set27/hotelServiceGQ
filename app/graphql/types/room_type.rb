# frozen_string_literal: true

module Types
  class RoomType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :price, Integer
    field :capacity, Integer
    field :rating, Types::EnumType
    field :is_occupied, Boolean
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
