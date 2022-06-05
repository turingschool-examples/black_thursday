require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/sales_analyst"


RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    @sales_analyst = @sales_engine.analyst
  end

  it "exists" do

    expect(@sales_analyst).to be_instance_of SalesAnalyst
    # expect(@sales_analyst.items_path).to be_instance_of Array
  end

  it "can group by merchant id" do

    expect(@sales_analyst.group_by_merchant_id).to be_a Hash
  end

  it "can return an array of sums" do

    expect(@sales_analyst.array_of_sums).to be_a Array
  end

  it "can calculate the average number of items per merchant" do

    expect(@sales_analyst.average_items_per_merchant).to eq 2.88
  end



end
