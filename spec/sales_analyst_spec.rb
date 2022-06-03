require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

RSpec.describe SalesAnalyst do
  it "exists" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_a SalesAnalyst
  end
end
