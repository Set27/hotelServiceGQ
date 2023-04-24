# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  def scoping
    scope = Request.all if user&.admin?
    scope = Request.where(user_id: user.id) if user&.user?

    scope
  end

  def create?
    # user.present? && user.admin?
    user&.user?
  end

  def show?
    user&.admin?
  end

  def attach?
    user&.admin?
  end
end
