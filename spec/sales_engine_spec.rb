require './lib/sales_engine'
require 'csv'

RSpec.describe SalesEngine do

  it 'exists' do
    se = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"
    })
    expect(se).to be_a(SalesEngine)
  end

  it 'returns the a loaded MerchantRepository' do
     se = SalesEngine.new({
       :items     => "./data/items.csv",
       :merchants => "./data/merchants.csv",
       :invoices => "./data/invoices.csv"
       })
     expect(se.merchants).not_to be nil
  end

  it 'returns the a loaded ItemRepository' do
     se = SalesEngine.new({
       :items     => "./data/items.csv",
       :merchants => "./data/merchants.csv",
       :invoices => "./data/invoices.csv"
       })
     expect(se.items).not_to be nil
  end

  it 'returns the a loaded InvoiceRepository' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })
     expect(se.invoices.all).not_to be nil
  end

  it 'can allow access to repository data' do
    se = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"
    })
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    expect(merchant).to be_a(Merchant)
    mi = se.invoices
    invoices = mi.find_by_id("1")
    expect(invoices).to be_a(Invoice)
  end
end
