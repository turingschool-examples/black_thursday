require './lib/item'
require './lib/merchant'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_engine'

RSpec.describe SalesEngine do

  describe '#initialize' do
    xit 'exists' do
      se = SalesEngine.new

      expect(se).to be_a SalesEngine
    end
  end

  describe '#from_csv' do
    it 'loads data from csv files' do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      mr = se.merchants
      expect(mr).to be_a MerchantRepository
    end
  end
end
