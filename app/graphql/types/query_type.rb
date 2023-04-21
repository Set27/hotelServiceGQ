module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include ActionPolicy::GraphQL::Behaviour

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :room, Types::RoomType, null: true do
      description "Retrieve a room by ID"
      argument :id, ID, required: true
    end
  
    def room(id:)
      Room.find_by(id: id)
    end

    field :request, Types::RequestType, null: true do
      argument :id, ID, required: true
    end

    def request(id:)
      Request.find_by(id: id)
    end

    field :all_requests, [Types::RequestType], null: false, description: "Get all requests"

    def all_requests
      authorize! Request, to: :show?
      Request.all
    end

    field :requeststs, resolver: Resolvers::RequestSearch
  end
end
