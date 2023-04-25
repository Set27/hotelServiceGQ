# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::CreateRoom, type: :mutation do
  describe ".resolve" do
    let(:admin) { create(:admin) }
    let(:context) { authenticated_context(admin) }
    let(:mutation) { described_class.new(object: nil, context:, field: nil) }

    let(:title) { "Example Room" }
    let(:price) { 100 }
    let(:capacity) { 2 }
    let(:rating) { "DELUXE" }
    let(:is_occupied) { false }

    let(:resolve_room_creation) do
      mutation.resolve(
        title:,
        price:,
        capacity:,
        rating:,
        is_occupied:,
      )
    end

    context "when room creation is successful" do
      it "returns the created room" do
        result = resolve_room_creation
        expect(result[:room]).to be_a(Room)
        expect(result[:room].title).to eq(title)
        expect(result[:room].price).to eq(price)
        expect(result[:room].capacity).to eq(capacity)
        expect(result[:room].rating).to eq(rating)
        expect(result[:room].is_occupied).to eq(is_occupied)
      end
    end

    context "when room creation fails" do
      let(:invalid_rating) { "JELUX" }

      let(:resolve_room_creation_with_invalid_rating) do
        mutation.resolve(
          title:,
          price:,
          capacity:,
          rating: invalid_rating,
          is_occupied:,
        )
      end

      it "returns error messages" do
        begin
          resolve_room_creation_with_invalid_rating
        rescue ActiveRecord::StatementInvalid => error
          error_message = error.message
        end

        expect(error_message).to include("invalid input value for enum room_class: \"#{invalid_rating}\"")
      end
    end
  end
end
