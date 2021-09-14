require "rspec"
require "./lib/sales_engine"

describe SalesEngine do
  before(:each) do
    @se = SalesEngine.new
    @se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
})
  end
  it 'exists' do
    expect(@se).to be_a(SalesEngine)
  end
end
