require 'rails_helper'

RSpec.describe Mutations::CreateRoom do
  describe '#resolve' do
    let(:user) { create(:user) }
    let(:context) { authenticated_context(user) }
    let(:mutation) { described_class.new(object: nil, context: context, field: nil) }

    let(:title) { "Example Room" }
    let(:price) { 100 }
    let(:capacity) { 2 }
    let(:rating) { "DELUXE" }
    let(:is_occupied) { false }

    let(:resolve_room_creation) do
      mutation.resolve(
        title: title,
        price: price,
        capacity: capacity,
        rating: rating,
        is_occupied: is_occupied
      )
    end
    
    context 'when room creation is successful' do
      it 'returns the created room' do
        result = resolve_room_creation
        expect(result[:room]).to be_a(Room)
        expect(result[:room].title).to eq(title)
        expect(result[:room].price).to eq(price)
        expect(result[:room].capacity).to eq(capacity)
        expect(result[:room].rating).to eq(rating)
        expect(result[:room].is_occupied).to eq(is_occupied)
      end

      it 'returns no errors' do
        result = resolve_room_creation
        expect(result[:errors]).to be_empty
      end
    end

    context 'when room creation fails' do
      let(:invalid_rating) { "JELUX" }

      let(:resolve_room_creation_with_invalid_rating) do
        mutation.resolve(
          title: title,
          price: price,
          capacity: capacity,
          rating: invalid_rating,
          is_occupied: is_occupied
        )
      end

      it 'returns error messages' do
        begin
          resolve_room_creation_with_invalid_rating
        rescue ActiveRecord::StatementInvalid => e
          error_message = e.message
        end

        expect(error_message).to include("invalid input value for enum room_class: \"#{invalid_rating}\"")
      end
    end
  end
end