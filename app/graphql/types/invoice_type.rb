# frozen_string_literal: true

module Types
  class InvoiceType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
    global_id_field :id
    # field :id, ID, null: false
    field :room, Types::RoomType, null: false
    field :request, Types::RequestType, null: false
    field :price, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
