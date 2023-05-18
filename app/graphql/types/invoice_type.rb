# frozen_string_literal: true

module Types
  class InvoiceType < Types::BaseObject
    implements Types::BaseGlobalIdInterface

    field :room, Types::RoomType, null: false
    field :request, Types::RequestType, null: false
    field :price, Integer
  end
end
