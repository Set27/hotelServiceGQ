class RequestPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # Define the resolve method to filter requests based on user role
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  
  def create?
    # user.present? && user.admin?
    user&.user?
  end
  
  def show?
    user&.admin?
  end
end