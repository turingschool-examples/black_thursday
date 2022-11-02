require 'csv'
require './lib/sales_engine'
require './lib/merchant'
require './lib/item'
require './lib/merchant_repository'
require './lib/item_repository'

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se).to be_a (SalesEngine)
  end

  it 'has child instances' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se.items).to be_a (ItemRepository)
    expect(se.merchants).to be_a (MerchantRepository)
  end
  it 'can analyze' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se.analyst).to be_an_instance_of(SalesAnalyst)
  end
end
