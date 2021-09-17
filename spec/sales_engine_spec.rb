require 'rspec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require './lib/sales_analyst'
require 'csv'


describe SalesEngine do

  describe '#initialize' do
    it 'creates an instance of SalesEngine' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      expect(se).to be_an_instance_of SalesEngine
    end

    it 'has readable attributes' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      expect(se.merchants).to be_an_instance_of(MerchantsRepository)
      expect(se.items).to be_an_instance_of(ItemRepository)
    end
  end

  describe '#analyst' do
    it 'can create an instance of SalesAnalyst' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    end
  end

end
