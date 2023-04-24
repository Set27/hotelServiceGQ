# spec/graphql/resolvers/request_search_spec.rb

require 'rails_helper'

RSpec.describe Resolvers::RequestSearch do
  describe '#resolve' do
    let(:user) { create(:user) }
    let!(:request1) { create(:request, user: user, price: 19, created_at: Date.today) }
    let!(:request2) { create(:request, user: user, price: 100, created_at: Date.today+1) }
    let!(:request3) { create(:request, user: user, price: 200, created_at: Date.today+2) }

    before do
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    end

    describe '#apply_filter' do
      it 'returns requests with price greater than or equal to given value' do
        result = subject.apply_filter(Request.all, { price_greater_than: 20 })
        expect(result).to contain_exactly(request2, request3)
      end
  
      it 'returns all requests when no filters are given' do
        result = subject.apply_filter(Request.all, {})
        expect(result).to contain_exactly(request1, request2, request3)
      end
    end
  
    describe '#apply_sort' do
      it 'returns requests sorted by created_at in ascending order' do
        result = subject.apply_sort(Request.all, 'CREATED_AT_ASC')
        expect(result).to eq([request1, request2, request3])
      end
      
      it 'returns requests sorted by created_at in descending order' do
        result = subject.apply_sort(Request.all, 'CREATED_AT_DESC')
        expect(result).to eq([request3, request2, request1])
      end
  
      it 'returns requests in default order when invalid sort option is given' do
        result = subject.apply_sort(Request.all, 'invalid')
        expect(result).to contain_exactly(request1, request2, request3)
      end
    end
  end
end 