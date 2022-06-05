require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
  xit "exists" do
    sales_analyst = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"

    })
    expect(sales_analyst).to be_instance_of SalesAnalyst
  end
end
