class Request < ApplicationRecord
  belongs_to :user
  belongs_to :room, optional: true

  # scope :sorted_by_start_date, -> { order(start_date: :asc) }
  # scope :sorted_by_end_date, -> { order(end_date: :asc) }
  # scope :filtered_by_user, ->(user_id) {
  #   where(user_id: user_id)
  # }
end
