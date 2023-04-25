# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::CreateRequest, type: :mutation do
  describe "#resolve" do
    let(:user) { create(:user) }

    let(:context) { authenticated_context(user) }
    let(:mutation) { described_class.new(object: nil, context:, field: nil) }

    let(:room) { create(:room) }
    let(:request) { create(:request, user:, room:) }

    let(:resolve_request_creation) do
      mutation.resolve(
        price: request.price,
        capacity: request.capacity,
        room_id: room.id,
        user_id: user.id,
        start_date: request.start_date,
        end_date: request.end_date,
      )
    end

    context "when invoice creation is successful" do
      it "returns the created invoice" do
        result = resolve_request_creation

        expect(result[:request]).to be_a(Request)
        expect(result[:request].price).to eq(request.price)
      end
    end

    context "when invoice creation fails" do
      let(:resolve_request_creation_with_invalid_capacity) do
        mutation.resolve(
          price: request.price,
          capacity: -1,
          room_id: room.id,
          user_id: user.id,
          start_date: request.start_date,
          end_date: request.end_date,
        )
      end

      it "returns error messages" do
        begin
          resolve_request_creation_with_invalid_capacity
        rescue GraphQL::ExecutionError => error
          error_message = error.message
        end

        expect(error_message).to be_present
      end
    end
  end
end
