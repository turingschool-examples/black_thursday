require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require 'CSV'
require 'simplecov'
SimpleCov.start

RSpec.describe SalesEngine do

  describe '#initialize' do

    it "it exists" do
      se = SalesEngine.new
      expect(se).to be_a(SalesEngine)
    end

    it "can instantiate a merchants repository" do
      # se = SalesEngine.new
      se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            })
      # require 'pry'; binding.pry
      mr = se.merchants
      expect(mr).to be_a(MerchantRepository)
    end


  end



end
