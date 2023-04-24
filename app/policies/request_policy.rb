# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  def scoping
    Request.all if user&.admin?
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
