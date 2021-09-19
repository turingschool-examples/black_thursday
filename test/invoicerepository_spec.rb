require './lib/item'
require './lib/itemrepository'
require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchantrepository'
require './lib/invoice'
require './invoicerepository'
require 'csv'

describe InvoiceRepository do
  it 'exists' do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices

    expect(inv).to be_a(InvoiceRepository)
  end

  it 'finds by id' do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices
    invoice1 = inv.find_by_id(1)

    expect(invoice1.customer_id).to eq(1)
  end

  it 'finds all by customer id' do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices
    invoice1 = inv.find_all_by_customer_id(1)

    expect(invoice1).to be_a(Array)
    expect(invoice1.count).to eq(8)
  end

  it 'finds all by merchant id' do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices
    invoice1 = inv.find_all_by_merchant_id(12335955)

    expect(invoice1).to be_a(Array)
    expect(invoice1.count).to eq(12)
  end

  it 'finds all by merchant id' do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices
    invoice1 = inv.find_all_by_merchant_id(12335955)

    expect(invoice1).to be_a(Array)
    expect(invoice1.count).to eq(12)
  end
end
