# frozen_string_literal: true

class RoomPolicy < ApplicationPolicy
  def create?
    user&.admin?
  end

  def free
    Room.unoccupied if user.present?
  end

  def all
    if user&.admin?
      Room.all
    else
      Room.unoccupied
    end
  end
end
