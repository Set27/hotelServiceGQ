# frozen_string_literal: true

# spec/mutations/create_user_spec.rb

require "rails_helper"

RSpec.describe Mutations::CreateUser, type: :request do
  describe ".resolve" do
    let(:name) { "John Doe" }
    let(:role) { "ADMIN" }
    let(:email) { "john@example.com" }
    let(:password) { "password" }

    it "create a user" do
      post "/graphql", params: {
        query: query(name:, role:, email:, password:),
      }

      json = JSON.parse(response.body)
      data = json["data"]["createUser"]["user"]

      expect(data).to match({
        "id" => be_present,
        "name" => name,
        "role" => role,
        "email" => email,
      })

      expect(User.count).to eq(1)
    end

    def query(name:, role:, email:, password:)
      <<~GQL
          mutation {
            createUser(
              name: "#{name}",#{' '}
              role: #{role},
              authProvider: {
                credentials: {
                  email: "#{email}",
                  password: "#{password}"
                }
              }
            ) {
              user{
              id
              name
              email
              role
            }
            errors
          }
        }
      GQL
    end
  end
end
