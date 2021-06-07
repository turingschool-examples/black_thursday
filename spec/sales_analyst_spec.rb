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
    expect(@sa.total_revenue_by_date('2021-03-27 14:54:09 UTC')).to eq(BigDecimal(40)/100)
  end

  it 'can find top revenue earners with an argument' do
    expected = [33333, 11111, 77777]
    @sa.top_revenue_earners(3).each do |merchant|
      expected.each do |expected_id|
        expect(merchat.id).to eq(expected_id)
      end
    end
  end

end
