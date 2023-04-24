# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AttachRoomToRequest do
  describe '.resolve' do
    let(:admin) { create(:admin) }
    let(:context) { authenticated_context(admin) }
    let(:mutation) { described_class.new(object: nil, context:, field: nil) }

    let(:room) { create(:room) }
    let(:request) { create(:request) }

    let(:resolve_room_attachment) do
      mutation.resolve(
        room_id: room.id,
        request_id: request.id
      )
    end

    context 'when the user is authorized' do
      it 'attaches the room to the request' do
        result = resolve_room_attachment
        expect(result[:result]).to eq('Success')
        expect(request.reload.room).to eq(room)
      end

      context 'when the room is already occupied' do
        before do
          room.update(is_occupied: true)
        end

        it 'returns an error message' do
          result = resolve_room_attachment
          expect(result[:result]).to eq('Room already occupied')
          expect(request.reload.room).to be_nil
        end
      end
    end

    context 'when the user is not authorized' do
      let(:user) { create(:user) }
      let(:context) { authenticated_context(user) }

      it 'raises an error' do
        expect do
          resolve_room_attachment
        end.to raise_error(ActionPolicy::Unauthorized)
        expect(request.reload.room).to be_nil
      end
    end
  end
end
