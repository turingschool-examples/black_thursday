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

  it "can tell you the average items per merchant" do
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it "can tell you the standard deviation of average items per merchant" do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to be_instance_of(Float) #change to 3.26 if population sd
  end

  # xit "can tel"


end
