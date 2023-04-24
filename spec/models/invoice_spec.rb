# frozen_string_literal: true

require "rails_helper"

RSpec.describe Invoice do
  describe "factory" do
    let(:invoice) { build(:invoice) }

    it "is valid" do
      expect(invoice).to be_valid
    end

    it "has a request associated with it" do
      expect(invoice.request).to be_a(Request)
    end

    it "has a price between 1 and 500" do
      expect(invoice.price).to be_between(1, 500)
    end

    it "has a unique request_id" do
      create(:invoice, request: invoice.request)
      expect(invoice).not_to be_valid
      expect(invoice.errors[:request_id]).to include("has already been taken")
    end
  end
end
