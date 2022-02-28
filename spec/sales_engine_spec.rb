require "csv"
require './lib/sales_engine'
require "./lib/merchant"
require "./lib/invoice"
require 'pry'

RSpec.describe SalesEngine do

  se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"
  })

  it "exists" do
    se.analyst
    expect(se).to be_an_instance_of(SalesEngine)

  end

  it "returns merchants" do
    expect(se.items).to be_an_instance_of(CSV::Table)
    expect(se.merchants).to be_an_instance_of(CSV::Table)
  end

  it "creates instances of merchant and item" do
    expect(se.items_instanciator[0]).to be_an_instance_of(Item)
    expect(se.merchants_instanciator[0]).to be_an_instance_of(Merchant)
  end

end
