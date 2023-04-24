# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :request
  validates :request_id, uniqueness: true
end
