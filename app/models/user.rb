class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  def user?
    role == USER
  end

  def admin?
    role == ADMIN
  end
end
