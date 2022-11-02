require 'csv'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'

RSpec.describe SalesEngine do
  let!(:sales_engine) {SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})}
  it 'exists' do
    expect(sales_engine).to be_a(SalesEngine)
  end

  it 'has common roots to their repositories' do
    expect(sales_engine.items).to be_a(ItemRepository)
    expect(sales_engine.merchants).to be_a(MerchantRepository)
  end

  it 'can perform ItemRepository methods' do
    ir = sales_engine.items

    
    
  end
end