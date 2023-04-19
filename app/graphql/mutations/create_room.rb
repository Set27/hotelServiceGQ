module Mutations
  class CreateRoom < Mutations::BaseMutation
    argument :title, String, required: true
    argument :price, Integer, required: true
    argument :capacity, Integer, required: true
    argument :rating, Types::RatingEnum, required: true
    argument :is_occupied, Boolean, required: true

    field :room, Types::RoomType, null: true
    field :errors, [String], null: true

    def resolve(title:, price:, capacity:, rating:, is_occupied:)
      # Ensure current_user is an Admin
      if context[:current_user].is_a?(Admin)
        room = Room.create!(
          title: title,
          price: price,
          capacity: capacity,
          rating: rating,
          is_occupied: is_occupied
        )

        { room: room }
      else
        { errors: ["Only admins can create rooms."] }
      end
    end
  end
end