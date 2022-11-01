require 'csv'
require './lib/sales_engine'
require './lib/merchant'
# require './lib/item'
# require './lib/merchant_repository'
# require './lib/item_reposotory'

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    expect(se).to be_a (SalesEngine)
  end

end
