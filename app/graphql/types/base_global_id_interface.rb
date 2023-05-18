# frozen_string_literal: true

module Types
  module BaseGlobalIdInterface
    include GraphQL::Schema::Interface

    implements GraphQL::Types::Relay::Node

    global_id_field :id
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
