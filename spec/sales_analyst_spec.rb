require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

RSpec.describe SalesAnalyst do
  it "exists" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_a SalesAnalyst
  end
  it "shows average items per merchant" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant.class).to eq Float
    expect(sales_analyst.average_items_per_merchant).to eq 2.88
  end

  it "can check if invoice is paid in full" do
    expect(@sales_engine.invoice_paid_in_full?(1)).to eq true
  end

  it "returns the total #$ amount of the invoice with matching id" do
    expect(@sales_engine.invoice_total(1)).to eq 21067.77
  end

end
