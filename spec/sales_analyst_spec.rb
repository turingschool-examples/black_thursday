require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item_repository'

RSpec.describe SalesAnalyst do
  let(:sales_engine) {SalesEngine.from_csv({:items => './data/items.csv',
                                  :merchants => './data/merchants.csv'})}
  let(:sales_analyst) {sales_engine.analyst}

  it 'exists' do
    expect(sales_analyst).to be_a SalesAnalyst
  end

  describe '#average_items_per_merchant' do
    it 'gives how many items a merchant has on average' do
      expect(sales_analyst.average_items_per_merchant).to eq 2.88
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the stdev of merchant average # of items' do
      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq 3.26
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns merchants whose average # of items is >1 stdev' do
      avg = sales_analyst.average_items_per_merchant
      stdev = sales_analyst.average_items_per_merchant_standard_deviation

      expect(
        sales_analyst.merchants_with_high_item_count.all? {
          |merchant| sales_analyst.items.find_all_by_merchant_id(merchant.id).count > avg + stdev 
          }).to be true
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'returns a BigDecimal of average item price' do
      # require 'pry'; binding.pry
      expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq 16.66
      expect(sales_analyst.average_item_price_for_merchant(12334257)).to eq BigDecimal(38.33,4)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'returns the average of all merchant average prices' do
      expect(sales_analyst.average_average_price_per_merchant).to eq 350.29
    end
  end

  # describe '#golden_items' do
  #   it 'returns an array of all Item objects with price >2stdev above mean' do

  #   end
  # end

  describe '#average_item_price' do
    it 'returns the average item price' do
      expect(sales_analyst.average_item_price).to eq 252105.51
    end
  end
end