require_relative './spec_helper'

RSpec.describe Merchant do
  it 'exists' do
    se = SalesEngine.new({
      items: 'spec/fixtures/items.csv',
      merchants: 'spec/fixtures/merchants.csv',
      invoices: 'spec/fixtures/invoices.csv',
      customers: 'spec/fixtures/customers.csv',
      invoice_items: 'spec/fixtures/invoice_items.csv',
      transactions: 'spec/fixtures/transactions.csv'
      })
    m = Merchant.new({ id: 5, name: 'Turing School' }, se)
    expect(m).to be_a(Merchant)
  end

  it 'has attributes' do
    se = SalesEngine.new({
      items: 'spec/fixtures/items.csv',
      merchants: 'spec/fixtures/merchants.csv',
      invoices: 'spec/fixtures/invoices.csv',
      customers: 'spec/fixtures/customers.csv',
      invoice_items: 'spec/fixtures/invoice_items.csv',
      transactions: 'spec/fixtures/transactions.csv'
      })
    m = Merchant.new({ id: 5, name: 'Turing School' }, se)
    expect(m.id).to eq(5)
    expect(m.name).to eq('Turing School')
  end
end
