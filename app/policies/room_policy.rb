class RoomPolicy < ApplicationPolicy
  def create?
    # user.present? && user.admin?
    user&.admin?
  end
end