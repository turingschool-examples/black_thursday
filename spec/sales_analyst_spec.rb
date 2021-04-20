require './data/item_mocks'
require './data/merchant_mocks'
require './lib/sales_analyst'
require './lib/sales_engine'
require './spec/sales_analyst_mocks'

RSpec.describe SalesAnalyst do
  describe '#num_of_items_per_merchant' do
    it 'returns a hash with each merchant as key and number of items as value' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)

      sales_engine = sales_analyst.sales_engine
      merchants_as_mocks = sales_engine.merchants.all

      expected_hash = {
        merchants_as_mocks[0] => 3,
        merchants_as_mocks[1] => 7,
        merchants_as_mocks[2] => 4,
        merchants_as_mocks[3] => 12
      }

      actual = sales_analyst.num_of_items_per_merchant

      expect(actual).to be_a Hash
      expect(actual).to eq expected_hash
    end
  end

  describe '#average_items_per_merchant' do
    it 'averages the items per merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      expected_average = 6.5
      actual_average = sales_analyst.average_items_per_merchant

      expect(actual_average).to eq expected_average
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'calculates standard deviation for average items per merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      expected_deviation = (Math.sqrt((((3 - 6.5)**2) + ((7 - 6.5)**2) + ((4 - 6.5)**2) + ((12 - 6.5)**2)) / 3.0)).round(2)
      actual_deviation = sales_analyst.average_items_per_merchant_standard_deviation

      expect(actual_deviation).to eq expected_deviation
    end
  end

  describe '#standard_deviations_of_mean' do
    it 'calculates the n standard deviation of the mean of items per merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      std_dev = Math.sqrt((((3 - 6.5)**2) + ((7 - 6.5)**2) + ((4 - 6.5)**2) + ((12 - 6.5)**2)) / 3.0)
      mean = 6.5
      expected_range = mean + std_dev
      actual_range = sales_analyst.standard_deviations_of_mean(mean, std_dev)

      expect(actual_range).to eq expected_range
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns the merchants with a high number of items that are more than 1 std dev above of the mean' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      merchant_ids = [1, 3]
      actual_merchants = sales_analyst.merchants_with_high_item_count

      actual_merchants.each do |merchant|
        expect(merchant_ids.include?(merchant.id)).to eq true
      end
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'gets the average price for the given merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      sum_for_test = SalesAnalystMocks.price_sums_for_each_merchant[3]
      actual_average = sales_analyst.average_item_price_for_merchant(3)
      expected_average = sum_for_test / 12.0

      expect(actual_average).to eq (expected_average).round(2)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'get the average of all the averages for each merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      allow(sales_analyst).to receive(:average_item_price_for_merchant) { 50.0 }
      sum_of_averages = 200.0

      actual_avg_of_averages = sales_analyst.average_average_price_per_merchant
      expected_avg_of_averages = sum_of_averages / 4.0

      expect(actual_avg_of_averages).to eq expected_avg_of_averages
    end
  end

  describe '#golden_items' do
    it 'returns all items 2+ std deviations above the mean price' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)

      actual_items = sales_analyst.golden_items

      expect(actual_items.length).to eq 3
    end
  end
end
