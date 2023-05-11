# frozen_string_literal: true

module Types
  class RoomType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
    # field :id, ID, null: false
    global_id_field :id
    field :title, String
    field :price, Integer
    field :capacity, Integer
    field :rating, Types::RatingEnum
    field :request, Types::RequestType, null: true
    field :is_occupied, Boolean
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
