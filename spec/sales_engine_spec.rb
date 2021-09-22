require './lib/sales_engine'
require 'csv'

RSpec.describe SalesEngine do

  before :each do
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
  end

  it 'exists' do
    expect(@se).to be_a(SalesEngine)
  end

  it 'returns a loaded MerchantRepository' do
    expect(@se.merchants).not_to be nil
    expect(@se.merchants.all[0]).to be_a(Merchant)
  end

  it 'returns a loaded ItemRepository' do
    expect(@se.items).not_to be nil
    expect(@se.items.all[0]).to be_a(Item)
  end

  it 'returns a loaded InvoiceRepository' do
    expect(@se.invoices.all).not_to be nil
    expect(@se.invoices.all[0]).to be_an(Invoice)
  end

  it 'returns a loaded InvoiceItemRepository' do
    expect(@se.invoice_items.all).not_to be nil
    expect(@se.invoice_items.all[0]).to be_an(InvoiceItem)
  end

  it 'returns a loaded TransactionRepository' do
    expect(@se.transactions.all).not_to be nil
    expect(@se.transactions.all[0]).to be_an(Transaction)
  end

  it 'returns a loaded CustomerRepository' do
    expect(@se.customers.all).not_to be nil
    expect(@se.customers.all[0]).to be_a(Customer)
  end
end
