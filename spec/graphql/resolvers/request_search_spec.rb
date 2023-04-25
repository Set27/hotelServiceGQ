# frozen_string_literal: true

require "rails_helper"

RSpec.describe Resolvers::RequestSearch do
  describe "#resolve" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:admin) { create(:admin) }

    let!(:request1_array) do
      [
        create(:request, user: user1, price: 19, created_at: Date.today),
        create(:request, user: user1, price: 100, created_at: Date.today + 1),
        create(:request, user: user1, price: 200, created_at: Date.today + 2),
      ]
    end

    let!(:request2_array) do
      [
        create(:request, user: user2, price: 300, created_at: Date.today + 5),
        create(:request, user: user2, price: 400, created_at: Date.today + 10),
        create(:request, user: user2, price: 500, created_at: Date.today + 15),
      ]
    end

    let(:all_requests) { request1_array + request2_array }

    describe "class method test" do
      before do
        allow_any_instance_of(described_class).to receive(:current_user).and_return(admin)
      end

      describe "#apply_filter" do
        it "returns requests with price greater than or equal to given value" do
          result = subject.apply_filter(Request.all, {price_greater_than: 20})
          expect(result).to match_array((request1_array[1, 2] + request2_array))
        end

        it "returns all requests when no filters are given" do
          result = subject.apply_filter(Request.all, {})
          expect(result).to match_array(all_requests)
        end
      end

      describe "#apply_sort" do
        it "returns requests sorted by created_at in ascending order" do
          result = subject.apply_sort(Request.all, "CREATED_AT_ASC")
          expect(result).to eq(all_requests)
        end

        it "returns requests sorted by created_at in descending order" do
          result = subject.apply_sort(Request.all, "CREATED_AT_DESC")
          expect(result).to eq(all_requests.reverse)
        end

        it "returns requests in default order when invalid sort option is given" do
          result = subject.apply_sort(Request.all, "invalid")
          expect(result).to match_array(all_requests)
        end
      end
    end

    describe "graphql query" do
      let(:query) do
        <<-GRAPHQL
          query {
            requests {
              id
            }
          }
        GRAPHQL
      end

      describe "admin" do
        let(:admin_context) { authenticated_context(admin) }

        describe "filter & order test" do
          let(:query) do
            <<-GRAPHQL
              query {
                requests(filter: { userId: "#{user1.id}" }, orderBy: CREATED_AT_ASC) {
                  id
                  price
                  user{
                    id
                  }
                }
              }
            GRAPHQL
          end

          it "returns requests for given user id and sorted by created_at in ascending order" do
            result = HotelServiceSchema.execute(query:, context: admin_context).as_json
            expect(result.dig("data", "requests")).to eq([
              {"id" => request1_array[0].id.to_s, "price" => request1_array[0].price,
               "user" => {"id" => user1.id.to_s}},
              {"id" => request1_array[1].id.to_s, "price" => request1_array[1].price,
               "user" => {"id" => user1.id.to_s}},
              {"id" => request1_array[2].id.to_s, "price" => request1_array[2].price,
               "user" => {"id" => user1.id.to_s}},
            ])
          end
        end
      end

      describe "user try to get all request" do
        let(:context1) { authenticated_context(user1) }

        it "return only request belong to user" do
          result = HotelServiceSchema.execute(query:, context: context1).as_json
          expect(result.dig("data", "requests")).to eq([
            {"id" => request1_array[0].id.to_s},
            {"id" => request1_array[1].id.to_s},
            {"id" => request1_array[2].id.to_s},
          ])
        end
      end
    end
  end
end
