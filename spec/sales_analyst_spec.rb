require_relative '../lib/sales_analyst'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require 'csv'
require 'bigdecimal'

RSpec.describe SalesAnalyst do
  before(:each) do
    @se = SalesEngine.new({items: './spec/fixtures/mock_items.csv',
                          merchants: './spec/fixtures/mock_merchants.csv',
                          invoices: './spec/fixtures/mock_invoices.csv',
                          invoice_items: './spec/fixtures/mock_invoice_items.csv',
                          transactions: './spec/fixtures/mock_transactions.csv',
                          customers: './spec/fixtures/mock_customers.csv'})
    @sa = @se.analyst
  end

  it 'exists' do
    expect(@sa).to be_a(SalesAnalyst)
  end

  it 'finds the total revenue by date' do
    date = Time.parse("2009-02-07")
    expected = @sa.total_revenue_by_date(date)

    expect(expected).to eq 0.1300042e5
    expect(expected.class).to eq BigDecimal
  end

  it 'can find top revenue earners with an argument' do
    expected = @sa.top_revenue_earners(3)
    first = expected.first
    last = expected.last

    expect(first.class).to eq Merchant
    expect(first.id).to eq 33333

    expect(last.class).to eq Merchant
    expect(last.id).to eq 77777
  end

  it 'can find top revenue earners with no argument' do
    expected = @sa.top_revenue_earners
    first = expected.first
    last = expected.last

    expect(expected.length).to eq 10

    expect(first.class).to eq Merchant
    expect(first.id).to eq 33333

    expect(last.class).to eq Merchant
  end

end
