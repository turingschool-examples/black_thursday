require 'rspec'
require './data/mock_data'
require './lib/sales_analyst'
require './lib/sales_engine'
require './spec/sales_analyst_mocks'
require 'pry'

RSpec.describe SalesAnalyst do
  describe '#num_of_items_per_merchant' do
    it 'returns a hash with each merchant as key and number of items as value' do
      sales_engine_mock = SalesAnalystMocks.sales_engine_mock(self)
      sales_analyst = sales_engine_mock.analyst

      items_as_hashes = MockData.items_as_hashes(number_of_hashes: 30, merchant_id_range: (0..0))
      items_as_mocks = MockData.items_as_mocks(self, items_as_hashes)

      merchants_as_hashes = MockData.merchants_as_hashes(number_of_hashes:1)
      merchants_as_mocks = MockData.merchants_as_mocks(self, merchants_as_hashes)

      allow(sales_engine_mock.items).to receive(:all).and_return items_as_mocks
      allow(sales_engine_mock.merchants).to receive(:all).and_return merchants_as_mocks

      expected_hash = {
        merchants_as_mocks[0] => 30
      }

      actual = sales_analyst.num_of_items_per_merchant

      expect(actual).to be_a Hash
      expect(actual).to eq expected_hash
    end
  end

  describe '#average_items_per_merchant' do
    it 'averages the items per merchant' do
      sales_engine_mock = SalesAnalystMocks.sales_engine_mock(self)
      sales_analyst = sales_engine_mock.analyst

      items_as_mocks = MockData.items_as_mocks(self)
      merchants_as_hashes = MockData.merchants_as_hashes(number_of_hashes:2)
      merchants_as_mocks = MockData.merchants_as_mocks(self, merchants_as_hashes)

      allow(sales_engine_mock.items).to receive(:all).and_return items_as_mocks
      allow(sales_engine_mock.merchants).to receive(:all).and_return merchants_as_mocks

      expected_average = 5
      actual_average = sales_analyst.average_items_per_merchant

      expect(actual_average).to eq expected_average
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'calculates standard deviation for average items per merchant' do
      sales_engine_mock = SalesAnalystMocks.sales_engine_mock(self)
      sales_analyst = sales_engine_mock.analyst

      items_as_hashes = MockData.items_as_hashes(number_of_hashes: 3, merchant_id_range: (1..1))
      items_as_hashes += MockData.items_as_hashes(number_of_hashes: 7, merchant_id_range: (2..2))
      items_as_hashes += MockData.items_as_hashes(number_of_hashes: 4, merchant_id_range: (3..3))
      items_as_hashes += MockData.items_as_hashes(number_of_hashes: 12, merchant_id_range: (4..4))

      items_as_mocks = MockData.items_as_mocks(self, items_as_hashes)
      merchants_as_hashes = MockData.merchants_as_hashes(number_of_hashes: 4)
      merchants_as_mocks = MockData.merchants_as_mocks(self, merchants_as_hashes)

      allow(sales_engine_mock.items).to receive(:all).and_return items_as_mocks
      allow(sales_engine_mock.merchants).to receive(:all).and_return merchants_as_mocks

      expected_deviation = Math.sqrt( ( ((3-6)**2)+((7-6)**2)+((4-6)**2)+((12-6)**2) ) / 3.0 )
      actual_deviation = sales_analyst.average_items_per_merchant_standard_deviation
      expect(actual_deviation).to eq expected_deviation
    end
  end

  describe '#n_standard_deviations_of_mean_items_per_merchant' do
    it 'calculates the n standard deviation of the mean of items per merchant' do

    end
  end
end
