# frozen_string_literal: true

module Mutations
  class CreateRequest < BaseMutation
    argument :price, Integer, required: true
    argument :capacity, Integer, required: true
    argument :room_id, ID, required: false
    argument :user_id, ID, required: true

    field :request, Types::RequestType, null: false

    def resolve(price:, capacity:, room_id:, user_id:)
      request = Request.new(
        price:,
        capacity:,
        room_id:,
        user_id:,
      )

      authorize! request, to: :create?

      if request.save
        {
          request:,
        }
      else
        errors = user.errors.full_messages.map { |error| {message: error} }
        raise GraphQL::ExecutionError.new(
          "Failed to create request", extensions: {errors:}
        )
      end
    end
  end
end
