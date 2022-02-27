require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative 'spec_helper'


RSpec.describe SalesEngine do
    before(:each) do
      @se = SalesEngine.from_csv({:items=> "./data/items.csv", :merchants => "./data/merchants.csv", :invoices=> "./data/invoices.csv"})

    end
    it 'exists' do
      expect(@se).to be_a(SalesEngine)
    end

    it 'has / can read merchants' do
      expect(@se.merchants.all.count).to be(475)
    end

    it 'has / can read items' do
      expect(@se.items.all.count).to be(1367)
    end

    xit 'has / can read invoices' do
      expect(@se.invoices.all.count).to be()
    end
end
