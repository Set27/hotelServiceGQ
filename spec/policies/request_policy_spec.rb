# frozen_string_literal: true

require "rails_helper"
require "action_policy/rspec/dsl"

RSpec.describe RequestPolicy, type: :policy do
  let(:user) { build_stubbed(:user) }
  let(:admin) { build_stubbed(:admin) }
  let(:record) { build_stubbed(:request) }
  let(:context) { {user: current_user} }

  describe_rule :create? do
    succeed "when user is a regular user" do
      let(:current_user) { user }
    end

    failed "when user is an admin" do
      let(:current_user) { admin }
    end
  end

  describe_rule :show? do
    succeed "when user is an admin" do
      let(:current_user) { admin }
    end

    failed "when user is a regular user" do
      let(:current_user) { user }
    end
  end

  describe_rule :attach? do
    succeed "when user is an admin" do
      let(:current_user) { admin }
    end

    failed "when user is a regular user" do
      let(:current_user) { user }
    end
  end

  describe "relation scope" do
    subject { policy.scoping.pluck(:id) }

    let(:user1) { create(:user) }
    let(:admin) { create(:admin) }

    let(:context) { {user: current_user} }

    let!(:request_for_user1) { create(:request, user: user1) }
    let!(:request_for_admin) { create(:request, user: admin) }

    context "when the user is an admin" do
      let(:current_user) { admin }

      it "returns all requests" do
        is_expected.to contain_exactly(request_for_user1.id, request_for_admin.id)
      end
    end

    context "when the user is a regular user" do
      let(:current_user) { user1 }

      it "returns requests for the user" do
        is_expected.to contain_exactly(request_for_user1.id)
      end
    end

    context "when the user is not authenticated" do
      let(:current_user) { nil }

      it "returns error" do
        expect { subject }.to raise_error(ActionPolicy::AuthorizationContextMissing)
      end
    end
  end
end
