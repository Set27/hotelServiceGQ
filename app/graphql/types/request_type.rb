# frozen_string_literal: true

module Types
  class RequestType < Types::BaseObject
    field :id, ID, null: false
    field :price, Integer
    field :capacity, Integer
    field :room, Types::RoomType
    field :user, Types::UserType, null: false
    field :start_date, GraphQL::Types::ISO8601Date
    field :end_date, GraphQL::Types::ISO8601Date
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
