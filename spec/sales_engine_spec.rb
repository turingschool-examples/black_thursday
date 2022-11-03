require 'csv'
require './lib/sales_engine'
require './lib/merchant'

RSpec.describe SalesEngine do
  it 'exists' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    expect(sales_engine).to be_a(SalesEngine)
  end

  it 'has common roots to their repositories' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    expect(sales_engine.items).to be_a(ItemRepository)
    expect(sales_engine.merchants).to be_a(MerchantRepository)
  end
end