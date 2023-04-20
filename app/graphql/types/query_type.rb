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
 
    field :filtered_requests, [Types::RequestType], null: false, description: "Get filtered requests" do
      argument :price, Integer, required: false
      argument :capacity, Integer, required: false
      argument :user_id, ID, required: false
      argument :room_id, ID, required: false
    end
    
    def filtered_requests(price: nil, capacity: nil, user_id: nil, room_id: nil)
      authorize! Request, to: :show?

      # Use the Scope class from RequestPolicy to filter requests
      scope = RequestPolicy::Scope.new(context[:current_user], Request.all)
      requests = scope.resolve

      requests = requests.where(price: price) if price.present?
      requests = requests.where(capacity: capacity) if capacity.present?
      requests = requests.where(user_id: user_id) if user_id.present?
      requests = requests.joins(:room).where(rooms: { id: room_id }) if room_id.present?

      requests
    end
  end
end
