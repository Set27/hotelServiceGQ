# frozen_string_literal: true

require "rails_helper"

RSpec.describe Request do
  describe "end_date_after_start_date validation" do
    context "when end date is before start date" do
      let(:request) { build(:request, start_date: Date.today, end_date: Date.yesterday) }

      it "is not valid" do
        expect(request).not_to be_valid
        expect(request.errors[:end_date]).to include("must be after the start date")
      end
    end

    context "when end date is after start date" do
      let(:request) { build(:request, start_date: Date.today, end_date: Date.tomorrow) }

      it "is valid" do
        expect(request).to be_valid
      end
    end

    context "when end date is equal to start date" do
      let(:request) { build(:request, start_date: Date.today, end_date: Date.today) }

      it "is valid" do
        expect(request).to be_valid
      end
    end
  end
end
