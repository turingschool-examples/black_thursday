require './lib/sales_engine'
require 'csv'

RSpec.describe SalesEngine do

  it 'exists' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    expect(se).to be_a(SalesEngine)
  end

  it 'returns a loaded MerchantRepository' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
     expect(se.merchants).not_to be nil
  end

  it 'returns a loaded ItemRepository' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
     expect(se.items).not_to be nil
  end

  it 'returns a loaded InvoiceRepository' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
     expect(se.invoices.all).not_to be nil
  end

  it 'returns a loaded InvoiceItemRepository' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
     expect(se.invoice_items.all).not_to be nil
  end

  it 'returns a loaded TransactionRepository' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
     expect(se.transactions.all).not_to be nil
  end

  it 'returns a loaded CustomerRepository' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
     expect(se.customers.all).not_to be nil
  end

  it 'can allow access to repository data' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    expect(merchant).to be_a(Merchant)
    mit = se.items
    item = mit.all[0]
    expect(item).to be_an(Item)
    mi = se.invoices
    invoice = mi.find_by_id("1")
    expect(invoice).to be_an(Invoice)
    mii = se.invoice_items
    invoice_item = mii.all[0]
    expect(invoice_item).to be_an(InvoiceItem)
    mt = se.transactions
    transaction = mt.all[0]
    expect(transaction).to be_a(Transaction)
    mc = se.customers
    customer = mc.all[0]
    expect(customer).to be_a(Customer)
  end
end
