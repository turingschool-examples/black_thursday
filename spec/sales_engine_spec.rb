require 'rspec'
require 'csv'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  it "exists" do
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })

  expect(se).to be_a(SalesEngine)
  end

end #RSpec end
