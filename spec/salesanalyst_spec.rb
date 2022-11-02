require './lib/salesanalyst'
require './lib/salesengine'
require './lib/itemrepository'

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
    xit 'returns merchants whose average # of items is >1 stdev' do
      avg = sales_analyst.average_items_per_merchant
      stdev = sales_analyst.average_items_per_merchant_standard_deviation

      expect(
        sales_analyst.merchants_with_high_item_count.all? {
          |merchant| sales_analyst.items.find_all_by_merchant_id(merchant.id).count > avg + stdev 
          }).to be true
    end
  end
end