require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'

RSpec.describe do

  describe 'initialize' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./spec/fixtures/items_fixtures.csv",
                                        :merchants => "./spec/fixtures/merchants_fixtures.csv",
                                        })
    sales_analyst = sales_engine.analyst

    it 'exists' do
      expect(sales_analyst.engine).to be_an_instance_of(SalesEngine)
    end

    it 'looks up all merchants' do
      expect(sales_analyst.find_all_merchants[1]).to be_an_instance_of(Merchant)
    end

    it 'looks up all items' do
      expect(sales_analyst.find_all_items[1]).to be_an_instance_of(Item)
    end

    it 'calculates average_items_per_merchant' do
      # Average of 2.5 was verified by searching fixture file with first 10 ID's
      expected_array = [12334105,12334112,12334113,12334115,12334123,12334132,12334135,12334141,12334144,12334145]
      expect(sales_analyst.average_items_per_merchant(expected_array)).to eq(2.5)
    end

    it 'returns set of ten merchant ids' do
      first_ten_merchants = sales_engine.merchants.array_of_objects[0..9]
      expected_array = [12334105,12334112,12334113,12334115,12334123,12334132,12334135,12334141,12334144,12334145]
      allow(sales_analyst.find_all_merchants).to receive(:sample) do
        first_ten_merchants
      end

      expect(sales_analyst.sample_merchants_return_id).to eq(expected_array)
    end

    it 'returns standard deviation of merchant item count' do
      expected_array = [12334105,12334112,12334113,12334115,12334123,12334132,12334135,12334141,12334144,12334145]
      first_ten_merchants = sales_engine.merchants.array_of_objects[0..9]
      allow(sales_analyst.find_all_merchants).to receive(:sample) do
        first_ten_merchants
      end

      expect(sales_analyst.stnd_dev_of_merch_items).to be_between(5.1, 5.3)
    end
  end
end
