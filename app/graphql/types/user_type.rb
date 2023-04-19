module Types
  class UserType <  Types::BaseObject
    graphql_name "User"

    field :id, ID, null: false
    field :email, String, null: false
    # Add additional fields if needed
  end
end