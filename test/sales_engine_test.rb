require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe SalesEngine do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })}
  let!(:sales_engine_inv) {SalesEngine.from_csv({:invoices => "./data/invoices.csv"})}
  let!(:invoice_repo) {sales_engine_inv.invoices}

  it 'exists' do
    expect(sales_engine).to be_instance_of(SalesEngine)
  end

  it 'can return merchant repository' do
    merchant_repo = sales_engine.merchants

    expect(merchant_repo).to be_instance_of(MerchantRepository)
  end

  it 'can return item repository' do
    item_repo = sales_engine.items

    expect(item_repo).to be_instance_of(ItemRepository)
  end

  it 'can return invoice repository' do
    expect(invoice_repo).to be_instance_of(InvoiceRepository)
  end

end
