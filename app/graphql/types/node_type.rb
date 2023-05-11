# frozen_string_literal: true

module Types
  module NodeType
    include Types::BaseInterface
    # Add the `id` field
    include GraphQL::Types::Relay::NodeBehaviors
    field :id, ID, null: false
  end
end
