# frozen_string_literal: true

require "rails_helper"
require "action_policy/rspec/dsl"

RSpec.describe InvoicePolicy, type: :policy do
  let(:user) { build_stubbed(:user) }
  let(:record) { build_stubbed(:invoice) }
  let(:context) { {user:} }

  describe_rule :create? do
    let(:policy) { described_class.new(context:, record:, user:) }

    succeed "when user is admin" do
      let(:user) { build_stubbed(:admin) }
    end

    failed "when user is a regular user"
  end

  describe "relation scope" do
    subject { policy.scoping.pluck(:id) }

    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:admin) { create(:admin) }

    let(:context) { {user: current_user} }

    let!(:invoice_for_user1) { create(:invoice, request: create(:request, user: user1)) }
    let!(:invoice_for_user2) { create(:invoice, request: create(:request, user: user2)) }

    context "when the user is an admin" do
      let(:current_user) { admin }

      it "returns all invoices" do
        is_expected.to contain_exactly(invoice_for_user1.id, invoice_for_user2.id)
      end
    end

    context "when the user is a regular user" do
      let(:current_user) { user1 }

      it "returns invoices for their requests" do
        is_expected.to contain_exactly(invoice_for_user1.id)
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
