class InvoicePolicy < ApplicationPolicy
  def create?
    user&.admin?
  end
end