module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :room_title, String, null: true do
      description "Find a room's title by ID"
      argument :id, ID, required: true
    end

    # Define the resolver method for `room_title`
    def room_title(id:)
      Room.find(id).title
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
