# frozen_string_literal: true

require "rails_helper"

RSpec.describe Resolvers::InvoiceSearch do
  describe "#resolve" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:admin) { create(:admin) }

    let(:context1) { authenticated_context(user1) }
    let(:admin_context) { authenticated_context(admin) }

    let(:request1_1) { create(:request, user: user1, price: 10) }
    let(:request1_2) { create(:request, user: user1, price: 10) }
    let(:request1_3) { create(:request, user: user1, price: 10) }

    let(:request2_1) { create(:request, user: user2, price: 20) }
    let(:request2_2) { create(:request, user: user2, price: 20) }
    let(:request2_3) { create(:request, user: user2, price: 20) }

    let!(:invoice1_1) { create(:invoice, request: request1_1, created_at: Date.today) }
    let!(:invoice1_2) { create(:invoice, request: request1_2, created_at: Date.today + 2) }
    let!(:invoice1_3) { create(:invoice, request: request1_3, created_at: Date.today + 5) }

    let!(:invoice2_1) { create(:invoice, request: request2_1, created_at: Date.today + 10) }
    let!(:invoice2_2) { create(:invoice, request: request2_2, created_at: Date.today + 15) }
    let!(:invoice2_3) { create(:invoice, request: request2_3, created_at: Date.today + 20) }

    describe "class method test" do
      before do
        allow_any_instance_of(described_class).to receive(:current_user).and_return(user1)
      end

      describe "#apply_filter for user1" do
        it "returns invoices for given user id" do
          result = subject.apply_filter(Invoice.all, {user_id: user1.id})
          expect(result).to contain_exactly(invoice1_1, invoice1_2, invoice1_3)
        end

        it "returns all invoices when no filters are given" do
          result = subject.apply_filter(Invoice.all, {})
          expect(result).to contain_exactly(invoice1_1, invoice1_2, invoice1_3, invoice2_1, invoice2_2, invoice2_3)
        end
      end

      describe "#apply_sort" do
        it "returns invoices sorted by created_at in ascending order" do
          result = subject.apply_sort(Invoice.all, "CREATED_AT_ASC")
          expect(result).to eq([invoice1_1, invoice1_2, invoice1_3, invoice2_1, invoice2_2, invoice2_3])
        end

        it "returns invoices sorted by created_at in descending order" do
          result = subject.apply_sort(Invoice.all, "CREATED_AT_DESC")
          expect(result).to eq([invoice2_3, invoice2_2, invoice2_1, invoice1_3, invoice1_2, invoice1_1])
        end

        it "returns invoices in default order when invalid sort option is given" do
          result = subject.apply_sort(Invoice.all, "invalid")
          expect(result).to contain_exactly(invoice1_1, invoice1_2, invoice1_3, invoice2_1, invoice2_2, invoice2_3)
        end
      end
    end

    describe "graphql query" do
      let(:query) do
        <<-GRAPHQL
          query {
            invoices {
              id
            }
          }
        GRAPHQL
      end

      describe "user1" do
        describe "filter & order test" do
          let(:query) do
            <<-GRAPHQL
              query {
                invoices(filter: { userId: "#{user1.id}" }, orderBy: CREATED_AT_ASC) {
                  id
                  price
                  request{
                    id
                  }
                }
              }
            GRAPHQL
          end

          it "returns invoices for given user id and sorted by created_at in ascending order" do
            result = HotelServiceSchema.execute(query:, context: context1).as_json
            expect(result.dig("data", "invoices")).to eq([
              {"id" => invoice1_1.to_gid_param, "price" => invoice1_1.price,
               "request" => {"id" => request1_1.id.to_s}},
              {"id" => invoice1_2.to_gid_param, "price" => invoice1_2.price,
               "request" => {"id" => request1_2.id.to_s}},
              {"id" => invoice1_3.to_gid_param, "price" => invoice1_3.price,
               "request" => {"id" => request1_3.id.to_s}},
            ])
          end
        end

        describe "policy test" do
          it "return only user value" do
            result = HotelServiceSchema.execute(query:, context: context1).as_json
            expect(result.dig("data", "invoices")).to eq([
              {"id" => invoice1_1.to_gid_param},
              {"id" => invoice1_2.to_gid_param},
              {"id" => invoice1_3.to_gid_param},
            ])
          end
        end

        describe "admin" do
          it "return all invoces" do
            result = HotelServiceSchema.execute(query:, context: admin_context).as_json
            expect(result.dig("data", "invoices")).to eq([
              {"id" => invoice1_1.to_gid_param},
              {"id" => invoice1_2.to_gid_param},
              {"id" => invoice1_3.to_gid_param},
              {"id" => invoice2_1.to_gid_param},
              {"id" => invoice2_2.to_gid_param},
              {"id" => invoice2_3.to_gid_param},
            ])
          end
        end

        describe "node" do
          let(:query) do
            <<-GRAPHQL
              query {
                node(id: "#{invoice1_1.to_gid_param}"){
                  ... on Invoice {
                  id
                  price
                }
              }
            }
            GRAPHQL
          end

          it "return invoice by global ID" do
            result = HotelServiceSchema.execute(query:, context: admin_context).as_json

            expect(result.dig("data", "node")).to eq({
              "id" => invoice1_1.to_gid_param,
              "price" => invoice1_1.price,
            })
          end
        end
      end
    end
  end
end
