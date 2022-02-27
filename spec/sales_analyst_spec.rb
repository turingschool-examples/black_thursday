require './lib/sales_analyst'
require 'rspec'

describe Analyst do
  before (:each) do
    @sales_analyst = Analyst.new
  end

  it "finds average" do
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it "finds standard_devation" do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it "finds merchants_with_high_item_count" do
    expect(@sales_analyst.merchants_with_high_item_count).to eq([])
  end
end
