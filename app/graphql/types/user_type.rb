# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    implements Types::BaseGlobalIdInterface

    field :name, String, null: false
    field :email, String, null: false
    field :role, Types::RoleEnum, null: true
    field :request, Types::RequestType, null: true
  end
end
