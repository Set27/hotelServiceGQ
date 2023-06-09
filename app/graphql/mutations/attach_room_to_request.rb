# frozen_string_literal: true

module Mutations
  class AttachRoomToRequest < BaseMutation
    argument :room_id, ID, required: false
    argument :request_id, ID, required: true

    field :result, String, null: false

    def resolve(room_id:, request_id:)
      authorize! Request, to: :attach?

      request = Request.find(request_id)
      room = Room.find(room_id)
      return {result: "Room already occupied"} if room.is_occupied?

      request.update(room:) ? {result: "Success"} : {result: "Failed"}
    end
  end
end
