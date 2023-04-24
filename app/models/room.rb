# frozen_string_literal: true

class Room < ApplicationRecord
  has_one :request, dependent: :nullify
  scope :unoccupied, -> { where(is_occupied: false) }
end
