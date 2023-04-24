# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  describe "password encryption" do
    it "encrypts the password using BCrypt" do
      user = build(:user, password: "password123")
      expect(user.password_digest.present?).to be(true)
    end
  end

  describe "roles" do
    let(:user) { build(:user) }
    let(:admin) { build(:admin) }

    it "returns true for user? if the role is USER" do
      expect(user.user?).to be(true)
      expect(admin.user?).to be(false)
    end

    it "returns true for admin? if the role is ADMIN" do
      expect(admin.admin?).to be(true)
      expect(user.admin?).to be(false)
    end
  end
end
