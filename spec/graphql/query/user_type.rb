# frozen_string_literal: true

require "rails_helper"

RSpec.describe Types::UserType do
  let(:response) { execute(query:, context:) }
  let!(:user) { create(:admin) }
  let(:context) { authenticated_context(user) }
  let(:response_user) { response.dig("data", "user") }

  let(:query) do
    <<-GRAPHQL
      query {
        user(id: "#{user.id}") {
          id
          createdAt
          updatedAt
          role
        }
      }
    GRAPHQL
  end

  it "returns a user by ID" do
    expect(response_user).to eq({
      "id" => user.to_gid_param,
      "role" => user.role,
      "createdAt" => user.created_at.iso8601,
      "updatedAt" => user.updated_at.iso8601,
    })
  end

  context "node" do
    let(:response_user) { response.dig("data", "node") }

    let(:query) do
      <<-GRAPHQL
        query {
          node(id: "#{user.to_gid_param}") {
            ... on User{
              id
              createdAt
              updatedAt
              role
            }
          }
        }
      GRAPHQL
    end

    it "returns a user by global ID" do
      expect(response_user).to eq({
        "id" => user.to_gid_param,
        "role" => user.role,
        "createdAt" => user.created_at.iso8601,
        "updatedAt" => user.updated_at.iso8601,
      })
    end
  end

  def execute(query:, context:)
    HotelServiceSchema.execute(query:, context:)
  end
end
