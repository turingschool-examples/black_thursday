require "csv"
require './lib/sales_engine'
require 'pry'

RSpec.describe SalesEngine do

  it "exists" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    expect(se[:merchants]).to be_an_instance_of(CSV::Table)
  end

  it "returns merchants" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchant_repo = se[:merchants]
    # merchant = merchant_repo.find_by_name("CJsDecor")
    expect(merchant_repo.count).to eq(475)
  end

end
