require 'rspec'
require './lib/sales_engine'

RSpec.describe SalesEngine do

    it 'exists' do
      data_hash = {
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      }
      se = SalesEngine.new(data_hash)

      expect(se).to be_a(SalesEngine)
    end

    it 'can receive data from a csv' do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      expect(se).to be_a(SalesEngine)
      expect(se.items).to eq("./data/items.csv")
      expect(se.merchants).to be_a(MerchantRepository)
    end
end
