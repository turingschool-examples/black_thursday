require 'rspec'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  it "exists" do
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })

  expect(se).to be_an_instance_of(SalesEngine)
  end

end #RSpec end
