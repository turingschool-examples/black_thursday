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

  xit 'can perform MerchantRepository methods' do
    mr = sales_engine.merchants
    # require 'pry'; binding.pry
    expect(mr.find_by_id(12334112)).to eq(mr.all[1])
    expect(mr.find_by_name("MiniatureBikez")).to eq(mr.all[2])
    expect(mr.find_all_by_name("ham")).to eq([mr.all[21], mr.all[441]])    
  end

   it 'can have an item object reference the merchant object that is the merchant_id' do
    require 'pry'; binding.pry
  end
end