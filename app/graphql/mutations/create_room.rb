module Mutations
  class CreateRoom < Mutations::BaseMutation
    argument :title, String, required: true
    argument :price, Integer, required: true
    argument :capacity, Integer, required: true
    argument :rating, Types::RatingEnum, required: true
    argument :is_occupied, Boolean, required: true

    field :room, Types::RoomType, null: false

    def resolve(title:, price:, capacity:, rating:, is_occupied:)
      
      room = Room.new(
        title: title,
        price: price,
        capacity: capacity,
        rating: rating,
        is_occupied: is_occupied
      )
      
      authorize! room, to: :create?
      
      room.save!

      { room: room }
    end
  end
end