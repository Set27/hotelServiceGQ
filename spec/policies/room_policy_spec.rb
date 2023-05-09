# frozen_string_literal: true

require "rails_helper"
require "action_policy/rspec/dsl"

RSpec.describe RoomPolicy, type: :policy do
  let(:user) { build_stubbed(:user) }
  let(:admin) { build_stubbed(:admin) }
  let(:record) { build_stubbed(:room) }
  let(:context) { {user: current_user} }

  describe_rule :create? do
    succeed "when user is an admin" do
      let(:current_user) { admin }
    end

    failed "when user is a regular user" do
      let(:current_user) { user }
    end
  end

  describe "free rooms scope" do
    subject { policy.free.pluck(:id) }

    let(:user1) { create(:user) }
    let(:admin) { create(:admin) }

    let!(:occupied_room) { create(:room, is_occupied: true) }
    let!(:unoccupied_room) { create(:room, is_occupied: false) }

    let(:context) { {user: current_user} }

    context "when user is authenticated" do
      let(:current_user) { user1 }

      it "returns unoccupied rooms" do
        is_expected.to contain_exactly(unoccupied_room.id)
      end
    end

    context "when user is not authenticated" do
      let(:current_user) { nil }

      it "returns error" do
        expect { subject }.to raise_error(ActionPolicy::AuthorizationContextMissing)
      end
    end
  end

  describe "all rooms scope" do
    subject { policy.all.pluck(:id) }

    let(:user1) { create(:user) }
    let(:admin) { create(:admin) }

    let!(:occupied_room) { create(:room, is_occupied: true) }
    let!(:unoccupied_room) { create(:room, is_occupied: false) }

    let(:context) { {user: current_user} }

    context "when user is an admin" do
      let(:current_user) { admin }

      it "returns all rooms" do
        is_expected.to contain_exactly(occupied_room.id, unoccupied_room.id)
      end
    end

    context "when user is a regular user" do
      let(:current_user) { user1 }

      it "returns unoccupied rooms" do
        is_expected.to contain_exactly(unoccupied_room.id)
      end
    end

    context "when user is not authenticated" do
      let(:current_user) { nil }

      it "returns error" do
        expect { subject }.to raise_error(ActionPolicy::AuthorizationContextMissing)
      end
    end
  end
end
