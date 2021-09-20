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

  it 'finds all by status' do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices
    invoice1 = inv.find_all_by_status("pending")
    invoice2 = inv.find_all_by_status("shipped")

    expect(invoice1).to be_a(Array)
    expect(invoice1.count).to eq(1473)
    expect(invoice2.count).to eq(2839)
  end

  it "can create a new invoice with max_id being +1" do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices

    attributes = {
                  :id           => 4986,
                  :customer_id  => 2,
                  :merchant_id  => 12334839,
                  :status       => "shipped",
                  :created_at   => "2020-09-17",
                  :updated_at   => "2021-08-13"
                  }

    expect(inv.all.length).to eq(4985)
    inv.create(attributes)
    expect(inv.all.length).to eq(4986)
  end

  xit "can update status" do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices

    invoice1 = inv.find_by_id(4965)

    i = {
            :id           => 4965,
            :customer_id  => 996,
            :merchant_id  => 12334839,
            :status       => "pending",
            :created_at   => "2012-01-22",
            :updated_at   => 2013-12-17
            }

    attributes =  {
            :id           => 4965,
            :customer_id  => 996,
            :merchant_id  => 12334839,
            :status       => "shipped",
            :created_at   => "2012-01-22",
            :updated_at   => Time.now
            }

    results = {
                  :id           => 4965,
                  :customer_id  => 996,
                  :merchant_id  => 12334839,
                  :status       => "shipped",
                  :created_at   => "2012-01-22",
                  :updated_at   => Time.now
                  }

  invoice_results = Invoice.new(results)
  expect(inv.update(4965, attributes).merchant_id).to eq(invoice_results.merchant_id)
  expect(inv.update(4965, attributes).customer_id).to eq(invoice_results.customer_id)
  end

  it 'deletes an invoice' do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
    inv = se.invoices

    expect(inv.delete(4965).length).to eq(4984)
  end
end
