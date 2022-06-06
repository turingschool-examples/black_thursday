require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require 'csv'

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv(
      {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv"
      }
    )
    @sales_analyst = @sales_engine.analyst
  end

   it "exist" do
     expect(@sales_analyst).to be_a SalesAnalyst
   end

   it "can calculate avg item per merchants" do
     expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
   end

   it "can return a hash with item count per merchant" do
       expect(@sales_analyst.items_per_merchant).to be_a(Hash)
       expect(@sales_analyst.items_per_merchant[12334105]).to eq(3)
   end

   it "can calculate average item per merchant standard deviation" do
     expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
   end

   it "can return the merchants more than one standard deviation from average products sold" do
     expect(@sales_analyst.merchants_with_high_item_count).to be_a Array
     expect(@sales_analyst.merchants_with_high_item_count[0]).to be_a Merchant
   end

   it "can find the average price of a merchant’s items" do
     expect(@sales_analyst.average_item_price_for_merchant(12334105)).to eq(1666)
   end

   it "can find sum all of the averages and find the average price across all merchants" do
    expect(@sales_analyst.average_average_price_per_merchant).to be_a BigDecimal
   end

   it "can return a hash of the average price per merchant" do
     expect(@sales_analyst.price_averages_per_merchant).to be_a(Hash)
     expect(@sales_analyst.price_averages_per_merchant[12334105]).not_to eq(nil)
   end

   it "can find the average price across merchants standard deviation" do
     expect(@sales_analyst.average_price_per_merchant_standard_deviation).to be_a(Float)
   end

   it "can return the items with price more than 2 standard deviations from average price(golden items)" do
     expect(@sales_analyst.golden_items).to be_a(Array)
     expect(@sales_analyst.golden_items.first).to be_a(Item)
     expect(@sales_analyst.golden_items.first).not_to eq([])
     expect(@sales_analyst.golden_items.first.unit_price).to be > (@sales_analyst.average_price_per_merchant_standard_deviation * 2)
   end

   it "can return the average invoice number per merchant" do
     expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
   end
end
