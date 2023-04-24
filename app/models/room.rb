# frozen_string_literal: true

class Room < ApplicationRecord
  has_one :request, dependent: :destroy
  scope :unoccupied, -> { where(is_occupied: false) }
end
