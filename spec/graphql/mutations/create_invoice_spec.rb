# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::CreateInvoice, type: :mutation do
  describe "#resolve" do
    let(:user) { create(:user) }
    let(:admin) { create(:admin) }

    let(:context) { authenticated_context(admin) }
    let(:user_context) { authenticated_context(user) }

    let(:mutation) { described_class.new(object: nil, context:, field: nil) }

    let(:room) { create(:room) }
    let(:request) { create(:request, user:, room:) }
    let(:invoice) { create(:invoice, request:) }

    let(:resolve_invoice_creation) do
      mutation.resolve(
        request_id: request.id,
      )
    end

    context "admin" do
      context "when invoice creation is successful" do
        it "returns the created invoice" do
          result = resolve_invoice_creation

          expect(result[:invoice]).to be_a(Invoice)
          expect(result[:invoice].request_id).to eq(request.id)
        end
      end

      context "when invoice creation fails" do
        let(:resolve_invoice_creation_with_invalid_rating) do
          mutation.resolve(
            request_id: 1,
          )
        end

        it "returns error messages" do
          begin
            resolve_invoice_creation_with_invalid_rating
          rescue ActiveRecord::RecordNotFound => error
            error_message = error.message
          end

          expect(error_message).to be_present
        end
      end
    end

    context "user" do
      let(:mutation) { described_class.new(object: nil, context: user_context, field: nil) }

      it "return errors" do
        begin
          resolve_invoice_creation
        rescue ActionPolicy::Unauthorized => error
          error_message = error.message
        end

        expect(error_message).to be_present
      end
    end
  end
end
