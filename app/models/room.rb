class Room < ApplicationRecord
  has_one :request, dependent: :nullify
end
