# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :request
  belongs_to :room, optional: true
  validates :request_id, uniqueness: true
end
