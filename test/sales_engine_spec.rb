require './lib/merchant_repository'
# require './lib/item_repository'
require './lib/merchant'
require './lib/sales_engine'
require 'pry'

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.new

    expect(se).to be_instance_of(SalesEngine)
  end

  it 'has merchants' do
    se = SalesEngine.new

  expect(se.merchants).to be_instance_of(MerchantRepository)
  end

  it 'has items' do
    se = SalesEngine.new

  expect(se.items).to be_instance_of(ItemRepository)
  end

  # xit 'has a merchant' do
  #   se = SalesEngine.new
  #   mr = se.merchants
  #   # mr.from_csv
  #   expect(mr.all.sample).to be_instance_of(Merchant)
  # end
  

  it 'creates a merchant and merchant repository' do
    # se = SalesEngine.new
    se = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => './data/merchants.csv'
                              })
                              # require 'pry'; binding.pry
    mr = se.merchants
    # require 'pry'; binding.pry
    merchant = mr.find_by_name('CJsDecor')

    expect(mr).to be_instance_of(MerchantRepository)
    expect(merchant).to be_instance_of(Merchant)
  end
end
