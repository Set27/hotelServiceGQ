module Types
  class MutationType < Types::BaseObject
    field :create_room, mutation: Mutations::CreateRoom
    field :sign_in_user, mutation: Mutations::SignInUser
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
