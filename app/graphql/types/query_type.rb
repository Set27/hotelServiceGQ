# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include ActionPolicy::GraphQL::Behaviour

    field :room, Types::RoomType, null: true do
      description "Retrieve a room by ID"
      argument :id, ID, required: true
    end

    def room(id:)
      Room.find_by(id:)
    end

    field :rooms, [Types::RoomType], null: true do
      argument :type, Types::RoomOccupiedEnum, required: false, default_value: "FREE"
    end

    def rooms(value)
      type = value[:type]
      case type
      when "FREE"
        authorize! Room, to: :free
      when "ALL"
        authorize! Room, to: :all
      end
    end

    field :request, Types::RequestType, null: true do
      argument :id, ID, required: true
    end

    def request(id:)
      Request.find_by(id:)
    end

    field :requests, resolver: Resolvers::RequestSearch

    field :invoice, Types::InvoiceType, null: true do
      argument :id, ID, required: true
    end

    def invoice(id:)
      Invoice.find_by(id:)
    end

    field :invoices, resolver: Resolvers::InvoiceSearch

    field :user, Types::UserType, null: true do
      description "Find a user by ID"
      argument :id, ID, required: true
    end

    def user(id:)
      authorize! User, to: :show?
      User.find_by(id:)
    end

    field :users, [Types::UserType], null: false, description: "Retrieve all users"

    def users
      authorize! User, to: :show?
      User.all
    end
  end
end
