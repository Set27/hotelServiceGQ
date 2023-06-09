# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  def scoping
    scope = Request.all if user&.admin?
    scope = Request.where(user_id: user.id) if user&.user?

    scope
  end

  def create?
    user&.user?
  end

  def show?
    user&.admin?
  end

  def attach?
    user&.admin?
  end

  def raise_unauthorized(msg = "Not Authorized")
    raise ActionPolicy::Unauthorized, msg
  end

  def authorize!(record, query_name = nil)
    super
  rescue ActionPolicy::Unauthorized => error
    raise_unauthorized("You are not authorized to perform this action")
  end
end
