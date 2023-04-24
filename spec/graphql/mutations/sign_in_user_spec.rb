require 'rails_helper'

RSpec.describe Mutations::SignInUser, type: :request do
  describe 'resolve' do
    let(:user) { create(:user) }
    let(:credentials) {{email: user[:email], password: 'password123'}}

    it 'login succesfull' do
      post '/graphql', params: {
        query: query(credentials: credentials)
      }

      json = JSON.parse(response.body)
      token_data = json['data']['signInUser']['token']
      user_data = json['data']['signInUser']['user']

      expect(token_data).to be_present
      
      expect(user_data).to eq(
        'id' => user.id.to_s,
        'name' => user.name,
        'email' => user.email,
        'role' => user.role
      )
    end
  end

  def query(credentials:)
    <<~GQL
      mutation {
        signInUser(
          credentials: {
            email: "#{credentials[:email]}",
            password: "#{credentials[:password]}"
          }
        ) {
          token,
          user{
            id
            name
            email
            role          
          }
        }
      }
    GQL
  end
end