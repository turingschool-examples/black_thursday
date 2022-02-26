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

    it "exists" do
      se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => "./data/invoices.csv"})
      expect(se).to be_a(SalesEngine)
    end

    it "can instantiate a merchants repository" do
      se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => "./data/invoices.csv"})
      mr = se.merchants
      expect(mr).to be_a(MerchantRepository)
    end

    it "can instantiate an item repository" do
      se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => "./data/invoices.csv"})
      ir = se.items
      expect(ir).to be_a(ItemRepository)
    end

    it "can instantiate an invoice repository" do
      se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => "./data/invoices.csv"})
      ir = se.invoices
      expect(ir).to be_a(InvoiceRepository)
    end


  end



end
