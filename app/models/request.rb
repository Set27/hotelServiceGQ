class Request < ApplicationRecord
  belongs_to :user
  belongs_to :room, optional: true
  has_one :invoice
end
