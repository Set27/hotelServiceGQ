# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :role, Types::RoleEnum, null: true
    field :request, Types::RequestType, null: true
  end
end
