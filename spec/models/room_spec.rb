# frozen_string_literal: true

require "rails_helper"

RSpec.describe Room do
  describe "scopes" do
    describe ".unoccupied" do
      let!(:occupied_room) { create(:room, is_occupied: true) }
      let!(:unoccupied_rooms) { create_list(:room, 3, is_occupied: false) }

      it "returns only unoccupied rooms" do
        expect(described_class.unoccupied).to match_array(unoccupied_rooms)
      end
    end
  end
end
