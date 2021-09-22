require './lib/item'
require './lib/itemrepository'
require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchantrepository'
require './lib/invoice'
require 'csv'
require './lib/invoice_item'
require './lib/invoice_item_repo'
require 'rspec'

describe InvoiceItemRepository do
  it 'exists' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    invi = se.invoice_items

    expect(invi).to be_a(InvoiceItemRepository)
  end

  it 'finds by id' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    invi = se.invoice_items
    invoiceitem1 = invi.find_by_id(1)
    invoiceitem2 = invi.find_by_id(371)

    expect(invoiceitem1.item_id).to eq(263519844)
    expect(invoiceitem2.item_id).to eq(263514300)
  end

  it 'finds all by item id' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    invi = se.invoice_items
    invoiceitem1 = invi.find_all_by_item_id(263524984)

    expect(invoiceitem1.first.id).to eq(370)
    expect(invoiceitem1).to be_a(Array)
  end

  it 'finds all by invoice id' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    invi = se.invoice_items
    invoiceitem1 = invi.find_all_by_invoice_id(3)

    expect(invoiceitem1.count).to eq(8)
    expect(invoiceitem1).to be_a(Array)
  end

  it "can create a new invoice item with max_id being +1" do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    invi = se.invoice_items

    attributes = {
                  :id           => 10,
                  :item_id      => 263523644,
                  :invoice_id   => 2,
                  :quantity     => 4,
                  :unit_price   => 1859,
                  :created_at   => "2012-03-27 14:54:09 UTC",
                  :updated_at   => "2012-03-27 14:54:09 UTC"
                  }


    expect(invi.all.length).to eq(21830)
    invi.create(attributes)
    expect(invi.all.length).to eq(21831)
  end

  it "can update attributes" do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    invi = se.invoice_items

    attribute = {
                  :id           => 10,
                  :item_id      => 263523644,
                  :invoice_id   => 2,
                  :quantity     => 10,
                  :unit_price   => 1500,
                  :created_at   => "2012-03-27 14:54:09 UTC",
                  :updated_at   => "2012-03-27 14:54:09 UTC"
                  }

    results = {
                  :id           => 10,
                  :item_id      => 263523644,
                  :invoice_id   => 2,
                  :quantity     => 10,
                  :unit_price   => 1500,
                  :created_at   => "2012-03-27 14:54:09 UTC",
                  :updated_at   => Time.now
                  }

  invoice_item_results = InvoiceItem.new(results)
  invi.update(10, attribute)

  expect(invi.find_by_id(10).quantity).to eq(invoice_item_results.quantity)
  end

  it 'deletes an invoice' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    invi = se.invoice_items

    expect(invi.delete(300).length).to eq(21829)
  end
end
