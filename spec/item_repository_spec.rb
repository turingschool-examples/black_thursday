#item_repository_spec
require './lib/item_repository'
# require './lib/items'
require './lib/sales_engine'
require 'pry'

RSpec.describe ItemRepository do
  before(:each) do
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  it 'exists' do
    expect(@se.items).to be_a(ItemRepository)
  end
end
