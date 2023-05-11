# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    implements GraphQL::Types::Relay::Node
    global_id_field :id
    # field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :role, Types::RoleEnum, null: true
    field :request, Types::RequestType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
