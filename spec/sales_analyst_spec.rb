require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/invoice_repository'
require './lib/merchant_repository'


RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv(
      {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
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
   it "can calculate average item per merchant standard deviation" do
     expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
   end
   it "can return the merchants more than one standard deviation from average products sold" do
     expect(@sales_analyst.merchants_with_high_item_count).to be_a Array
     expect(@sales_analyst.merchants_with_high_item_count[0]).to be_a Merchant
   end
end
