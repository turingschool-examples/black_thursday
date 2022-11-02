require './lib/merchant_repository'
# require './lib/item_repository'
require './lib/merchant'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  it 'creates a merchant and merchant repository' do
    se = SalesEngine.from_csv({
                                # :items     => "./data/items.csv",
                                merchants: './data/merchants.csv'
                              })
    mr = se.merchants
    require 'pry'
    binding.pry
    merchant = mr.find_by_name('CJsDecor')

    expect(mr).to be_instance_of(MerchantRepository)
    expect(merchant).to be_instance_of(Merchant)
  end
end
