require_relative './spec_helper'

RSpec.describe SalesEngine do
  before :each do
    @se = SalesEngine.new({
      items: 'spec/fixtures/items.csv',
      merchants: 'spec/fixtures/merchants.csv',
      invoices: 'spec/fixtures/invoices.csv',
      customers: 'spec/fixtures/customers.csv',
      invoice_items: 'spec/fixtures/invoice_items.csv',
      transactions: 'spec/fixtures/transactions.csv'
      })
  end

  it 'exists' do
    expect(@se).to be_a(SalesEngine)
  end

  it 'has attributes' do
    expect(@se.items).to be_an_instance_of(ItemRepository)
    expect(@se.merchants).to be_an_instance_of(MerchantRepository)
    expect(@se.invoices).to be_an_instance_of(InvoiceRepository)
    expect(@se.customers).to be_an_instance_of(CustomerRepository)
    expect(@se.invoice_items).to be_an_instance_of(InvoiceItemRepository)
    expect(@se.transactions).to be_an_instance_of(TransactionRepository)
    expect(@se.analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'returns instance of item repo with all items' do
    expect(@se.items.all[0]).to be_a(Item)
  end

  it 'returns instance of merchant repo with all merchants' do
    expect(@se.merchants.all[0]).to be_a(Merchant)
  end

  it 'returns instance of invoices repo with all merchants' do
    expect(@se.invoices.all[0]).to be_a(Invoice)
  end

  it 'returns instance of customer repo with all merchants' do
    expect(@se.customers.all[0]).to be_a(Customer)
  end

  it 'returns instance of invoice item repo with all merchants' do
    expect(@se.invoice_items.all[0]).to be_a(InvoiceItem)
  end

  it 'returns instance of transaction repo with all merchants' do
    expect(@se.transactions.all[0]).to be_a(Transaction)
  end
end
