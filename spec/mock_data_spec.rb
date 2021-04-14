require 'rspec'
require './data/mock_data'

describe MockData do
  describe '#get_mock_merchants' do
    it 'returns mock data as an array of hashes' do
      mocks = MockData.get_mock_merchants(10)

      expect(mocks).to be_instance_of Array
      expect(mocks.length).to eq 10
      expect(mocks.first).to be_instance_of Hash
    end

    it 'returns mock data of merchants with names and ids' do
      mocks = MockData.get_mock_merchants(2)
      mocked_merchant = mocks.first
      expect(mocked_merchant[:name]).to eq 'Merchant 0'
      expect(mocked_merchant[:id]).to eq 0
    end
  end
end
