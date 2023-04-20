class RequestPolicy < ApplicationPolicy
  def create?
    # user.present? && user.admin?
    user&.user?
  end
  
  def show?
    user&.admin?
  end
end