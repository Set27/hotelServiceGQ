# frozen_string_literal: true

require "rails_helper"

RSpec.describe Types::RoomType do
  let(:response) { execute(query:) }
  let!(:room) { create(:room) }
  let(:response_room) { response.dig("data", "room") }

  let(:query) do
    <<-GRAPHQL
      query {
        room(id: "#{room.id}") {
          id
          title
          price
          capacity
          rating
          request {
            id
          }
          isOccupied
          createdAt
          updatedAt
        }
      }
    GRAPHQL
  end

  it "returns a room by ID" do
    expect(response_room).to eq({
      "id" => room.to_gid_param,
      "title" => room.title,
      "price" => room.price,
      "capacity" => room.capacity,
      "rating" => room.rating,
      "request" => nil,
      "isOccupied" => room.is_occupied,
      "createdAt" => room.created_at.iso8601,
      "updatedAt" => room.updated_at.iso8601,
    })
  end

  context "node" do
    let(:response_room) { response.dig("data", "node") }

    let(:query) do
      <<-GRAPHQL
        query {
          node(id: "#{room.to_gid_param}") {
            ... on Room{
              id
              capacity
            }
          }
        }
      GRAPHQL
    end

    it "returns a room by global ID" do
      expect(response_room).to eq({
        "id" => room.to_gid_param,
        "capacity" => room.capacity,
      })
    end
  end

  def execute(query:)
    HotelServiceSchema.execute(query:)
  end
end
