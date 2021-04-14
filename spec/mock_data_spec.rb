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

  describe '#get_mock_items' do
    it 'returns mock data as an array of hashes' do
      mocks = MockData.get_mock_items

      expect(mocks).to be_instance_of Array
      expect(mocks.length).to eq 10
      expect(mocks.first).to be_instance_of Hash
    end

    it 'returns mock data of items with data' do
      mocks = MockData.get_mock_items(2)
      mocked_item = mocks.first
      expect(mocks.length).to eq 2
      expect(mocked_item[:name]).to eq 'Item 0'
      expect(mocked_item[:id]).to eq 0
      expect(mocked_item[:merchant_id]).to be_instance_of Integer
      expect(mocked_item[:unit_price]).to be_instance_of Float
      expect(mocked_item[:description]).to eq 'Item Description'
      expect(mocked_item[:created_at]).to match /\d{4}-\d{2}-\d{2}/
      expect(mocked_item[:updated_at]).to match /\d{4}-\d{2}-\d{2}/
    end
  end

  describe '#get_a_random_price' do
    it 'generates a random price' do
      random_price = MockData.get_a_random_price
      expect(random_price).to be_instance_of Float
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

  describe '#sum_prices' do
    it 'sums prices' do
      allow(MockData).to receive(:get_a_random_price).and_return(1)
      mock_items = MockData.get_mock_items
      expected_sum = 10
      actual_sum = MockData.sum_prices(mock_items)
      expect(actual_sum).to eq expected_sum
    end
  end

  describe '#mean_price' do
    it 'sums prices' do
      allow(MockData).to receive(:get_a_random_price).and_return(5)
      mock_items = MockData.get_mock_items
      expected_mean = 5
      actual_mean = MockData.mean_price(mock_items)
      expect(actual_mean).to eq expected_mean
    end
  end
end
