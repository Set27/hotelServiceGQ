module Types
  class AuthenticatedObjectType < GraphQL::Schema::Object
    def self.authorized?(object, context)
      super && context[:current_user].present?
    end

    field :admin, Types::AdminType, null: true
    field :user, Types::UserType, null: true

    def admin
      object if object.is_a?(Admin)
    end

    def user
      object if object.is_a?(User)
    end
  end
end