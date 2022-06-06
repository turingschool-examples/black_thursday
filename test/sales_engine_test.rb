require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'
require 'rspec'

RSpec.describe SalesEngine do

  it 'exists' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

    expect(sales_engine).to be_instance_of(SalesEngine)
  end

  it 'can return merchant repository' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"

      })

    merchant_repo = sales_engine.merchants

    expect(merchant_repo).to be_instance_of(MerchantRepository)
  end

  it 'can return item repository' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

    item_repo = sales_engine.items

    expect(item_repo).to be_instance_of(ItemRepository)
  end

end
