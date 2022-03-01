require 'rspec'
require 'csv'
require './lib/sales_engine'
# require "./data/items.csv"
# require "./data/merchants.csv"
RSpec.describe SalesEngine do
  describe "from_csv" do
    it "exists" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv",})
        expect(se).to be_a(SalesEngine)
    end
    it "starts with no items or merchants" do
      se = SalesEngine.new
      expect(se.items_array).to eq([])
      expect(se.merchants_array).to eq([])
    end
    it "adds info from CSV files" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :invoices     => "./data/invoices.csv",
        :invoice_items     => "./data/invoice_items.csv",
        :customers     => "./data/customers.csv",
        :transactions     => "./data/transactions.csv",
        :merchants => "./data/merchants.csv",})
      expect(se.items_array).to_not be([])
      expect(se.merchants_array).to_not be([])
    end
    it "mr to be a repo" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :invoices     => "./data/invoices.csv",
        :invoice_items     => "./data/invoice_items.csv",
        :customers     => "./data/customers.csv",
        :transactions     => "./data/transactions.csv",
        :merchants => "./data/merchants.csv",})
        mr = se.merchants
        expect(mr).to be_a(MerchantRepository)
    end
    it "ir to be a repo" do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :invoices     => "./data/invoices.csv",
        :invoice_items     => "./data/invoice_items.csv",
        :customers     => "./data/customers.csv",
        :transactions     => "./data/transactions.csv",
        :merchants => "./data/merchants.csv",})
        ir = se.items
        expect(ir).to be_a(ItemRepository)
    end
  end
end
