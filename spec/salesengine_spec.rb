require 'SimpleCov'
SimpleCov.start

require_relative '../lib/sales_engine'

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    expect(se).to be_an_instance_of(SalesEngine)
  end

  it 'initializes with attributes that create repository instances' do
    data = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    }

    se = SalesEngine.from_csv(data)

    expect(se.items).to be_an_instance_of(ItemRepository)
    expect(se.merchants).to be_an_instance_of(MerchantRepository)
  end
end
