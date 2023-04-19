# app/graphql/mutations/sign_in_user.rb
module Mutations
  class SignInUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.find_for_authentication(email: email)

      if user&.valid_password?(password)
        context[:current_user] = user
        { user: user, errors: [] }
      else
        { user: nil, errors: ["Invalid email or password."] }
      end
    end
  end
end