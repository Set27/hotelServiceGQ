# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_room, mutation: Mutations::CreateRoom
    field :create_user, mutation: Mutations::CreateUser
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_request, mutation: Mutations::CreateRequest
    field :create_invoice, mutation: Mutations::CreateInvoice
    field :attach_room_to_request, mutation: Mutations::AttachRoomToRequest

    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
