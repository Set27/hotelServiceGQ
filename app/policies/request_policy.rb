class RequestPolicy < ApplicationPolicy
  def create?
    # user.present? && user.admin?
    user&.user?
  end
end