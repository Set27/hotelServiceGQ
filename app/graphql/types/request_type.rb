# frozen_string_literal: true

module Types
  class RequestType < Types::BaseObject
    implements Types::BaseInterface

    field :price, Integer
    field :capacity, Integer
    field :room, Types::RoomType
    field :user, Types::UserType, null: false
    field :start_date, GraphQL::Types::ISO8601Date
    field :end_date, GraphQL::Types::ISO8601Date
  end
end
