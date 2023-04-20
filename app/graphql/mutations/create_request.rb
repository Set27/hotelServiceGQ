# frozen_string_literal: true

module Mutations
  class CreateRequest < BaseMutation
    argument :price, Integer, required: true
    argument :capacity, Integer, required: true
    argument :room_id, ID, required: false
    argument :user_id, ID, required: true

    field :request, Types::RequestType, null: false
    field :errors, [String], null: true

    def resolve(price:, capacity:, room_id:, user_id:)
      request = Request.new(
        price: price,
        capacity: capacity,
        room_id: room_id,
        user_id: user_id
      )

      authorize! request, to: :create?

      if request.save
        {
          request: request,
          errors: []
        }
      else
        {
          request: nil,
          errors: request.errors.full_messages
        }
      end
    end
  end
end