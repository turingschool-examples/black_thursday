require_relative 'spec_helper'
require_relative '../lib/sales_engine'
require 'csv'


RSpec.describe SalesEngine do
  before(:each) do
    @se = SalesEngine.from_csv({
      :items     => './spec/fixtures/mock_items.csv',
      :merchants => './spec/fixtures/mock_merchants.csv',
      :invoices => './spec/fixtures/mock_invoices.csv',
      :transactions => './spec/fixtures/mock_transactions.csv',
      :invoice_items => './spec/fixtures/mock_invoice_items.csv',
      :customers => './spec/fixtures/mock_customers.csv'})
  end

  it 'exists' do
    expect(@se).to be_an_instance_of(SalesEngine)
  end

  it 'can create an items repository' do
    expect(@se.items).to be_an_instance_of(ItemRepository)
  end

  it 'can create a merchant repository' do
    expect(@se.merchants).to be_an_instance_of(MerchantRepository)
  end

  it 'can create an invoice repository' do
    expect(@se.invoices).to be_an_instance_of(InvoiceRepository)
  end

  it 'can create a sales analyst' do
    expect(@se.analyst).to be_a(SalesAnalyst)
  end

  it 'can create a transaction repository' do
    expect(@se.transactions).to be_a(TransactionRepository)
  end

  it 'can create a customer repository' do
    expect(@se.customers).to be_a(CustomerRepository)
  end

  it 'can store invoice item total price by date' do
    expect(@se.revenue_by_date(Time.parse('2009-02-07'))).to eq({Time.parse('2009-02-07') => 0.8600264e5})
  end

  it 'can connect total invoice prices to merchant ids' do
    expect(@se.total_unit_price_by_merchant_id[11111]).to eq([0.8600264e5])
  end

  it 'can connect total price to merchant instance' do
    @se.price_by_merchant.each do |merchant, price|
      expect(merchant).to be_a(Merchant)
    end
  end

end
