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
      :invoice_items => './spec/fixtures/mock_invoice_items.csv'
    })
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

  it 'can create a transaction repositor' do
    expect(@se.transactions).to be_a(TransactionRepository)
  end
end
