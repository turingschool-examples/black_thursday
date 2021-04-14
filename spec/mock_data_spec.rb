require 'rspec'
require './data/mock_data'

describe MockData do
  describe '#get_mock_merchants' do
    it 'returns mock data as an array of hashes' do
      mocks = MockData.get_mock_merchants

      expect(mocks).to be_instance_of Array
      expect(mocks.length).to eq 10
      expect(mocks.first).to be_instance_of Hash
    end

    it 'returns mock data of merchants with data' do
      mocks = MockData.get_mock_merchants(2)
      mocked_merchant = mocks.first
      expect(mocks.length).to eq 2
      expect(mocked_merchant[:name]).to eq 'Merchant 0'
      expect(mocked_merchant[:id]).to eq 0
      expect(mocked_merchant[:created_at]).to match /\d{4}-\d{2}-\d{2}/
      expect(mocked_merchant[:updated_at]).to match /\d{4}-\d{2}-\d{2}/
    end
  end

  describe '#get_a_random_date' do
    it 'gets a random date with expected format' do
      date = MockData.get_a_random_date
      expect(date.to_s).to match /\d{4}-\d{2}-\d{2}/
    end
    it 'gets a non-random date' do
      first_date = MockData.get_a_random_date false
      second_date = MockData.get_a_random_date false
      expect(first_date.to_s).to eq second_date.to_s
    end
  end
end
