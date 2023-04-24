# frozen_string_literal: true

require_relative "../types/auth_provider_credentials_input"

module Mutations
  class CreateUser < BaseMutation
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :name, String, required: true
    argument :role, Types::RoleEnum, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    field :user, Types::UserType, null: false
    field :errors, [String], null: true

    def resolve(role:, name: nil, auth_provider: nil)
      user = User.new(
        name:,
        role:,
        email: auth_provider[:credentials][:email],
        password: auth_provider[:credentials][:password],
      )

      if user.save
        {
          user:,
        }
      else
        errors = user.errors.full_messages.map { |error| {message: error} }
        raise GraphQL::ExecutionError.new(
          "Failed to create user", extensions: {errors:}
        )
      end
    end
  end
end
