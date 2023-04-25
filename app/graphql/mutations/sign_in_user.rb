# frozen_string_literal: true

module Mutations
  class SignInUser < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      return unless credentials

      user = User.find_by email: credentials[:email]
      raise GraphQL::ExecutionError, "User not found" unless user
      return unless user
      raise GraphQL::ExecutionError, "Invalid password" unless user.authenticate(credentials[:password])

      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{user.id}")
      context[:session][:token] = token
      {user:, token:}
    end
  end
end
