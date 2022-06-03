require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe ItemRepository do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })}

  it 'exists' do
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
