module Mutations
  class CreateRoom < Mutations::BaseMutation
    argument :title, String, required: true
    argument :price, Integer, required: true
    argument :capacity, Integer, required: true
    argument :rating, Types::RatingEnum, required: true
    argument :is_occupied, Boolean, required: true

    field :room, Types::RoomType, null: false

    # type Types::RoomType

    def resolve(title:, price:, capacity:, rating:, is_occupied:)
      authorize! Room, to: :create?
      
      room = Room.new(
        title: title,
        price: price,
        capacity: capacity,
        rating: rating,
        is_occupied: is_occupied
      )
      
      if room.save
        {
          room: room,
        }
      else
        errors = user.errors.full_messages.map { |error| { message: error } }
        raise GraphQL::ExecutionError.new(
          "Failed to create room", extensions: { errors: errors }
        )
      end
    end
  end
end