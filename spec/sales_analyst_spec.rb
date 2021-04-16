require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'

RSpec.describe do

  describe 'initialize' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
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

    # it 'looks up all items a merchant sells by id lookup' do
    #   expect(sales_analyst.merchant_items_lookup(500000)).to eq(nil)
    #   expect(sales_analyst.merchant_items_lookup(12334105).name).to eq("Shopin1901")
    # end
  end
end
