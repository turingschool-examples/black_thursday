require_relative './spec_helper'

RSpec.describe SalesAnalyst do
  before :each do
    sales_engine = SalesEngine.from_csv({
     :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    @sales_analyst = sales_engine.analyst
  end

  it "is a SalesAnalyst" do
    expect(@sales_analyst).to be_instance_of(SalesAnalyst)
  end

  xit "can tell you the average items per merchant" do
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end



end
