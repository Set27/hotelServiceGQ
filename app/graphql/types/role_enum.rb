module Types
  class RoleEnum < GraphQL::Schema::Enum
    value "ADMIN"
    value "USER"
  end
end