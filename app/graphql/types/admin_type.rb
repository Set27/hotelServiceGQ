module Types
  class AdminType < Types::BaseObject
    graphql_name "Admin"

    field :id, ID, null: false
    field :email, String, null: false
    # Add additional fields if needed
  end
end