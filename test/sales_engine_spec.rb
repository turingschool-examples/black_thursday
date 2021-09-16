require './lib/sales_engine'
require './lib/item'
# require 'Rspec'
# require 'csv'
#
describe SalesEngine do

  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se).to be_a(SalesEngine)
  end

  it "" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    se.items
  end


end
