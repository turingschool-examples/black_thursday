require 'SimpleCov'
SimpleCov.start

require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_analyst'

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

  it 'can initialize sales analyst' do
    se = SalesEngine.from_csv({
                               :items     => "./data/items.csv",
                               :merchants => "./data/merchants.csv"
                             })
    sales_analyst = se.analyst

    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end
end
