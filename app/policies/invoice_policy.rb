# frozen_string_literal: true

class InvoicePolicy < ApplicationPolicy
  def create?
    user&.admin?
  end

  def scoping
    scope = Invoice.all if user&.admin?
    scope = Invoice.joins(:request).where(requests: {user_id: user.id}) if user&.user?

    scope
  end
end
