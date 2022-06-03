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
      :merchants => "./data/merchants.csv"
      })

    expect(sales_engine).to be_instance_of(SalesEngine)
  end

  it 'can return merchant repository' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      merchant_repo = sales_engine.merchants

    expect(merchant_repo).to be_instance_of(MerchantRepository)
  end

  it 'can return item repository' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    item_repo = sales_engine.items

    expect(item_repo).to be_instance_of(ItemRepository)
  end

  it 'can return invoice repository' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/invoices.csv"
      })

    invoice_repo = sales_engine.invoices

    expect(invoice_repo).to be_instance_of(InvoiceRepository)
  end

end
