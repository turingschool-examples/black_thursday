require_relative '../lib/sales_analyst'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require 'csv'

RSpec.describe SalesAnalyst do
  before(:each) do
    @se = SalesEngine.new({items: './spec/fixtures/mock_items.csv',
                          merchants: './spec/fixtures/mock_analyst_merchants.csv',
                          invoices: './spec/fixtures/mock_invoices.csv',
                          invoice_items: './spec/fixtures/mock_analyst_invoice_items.csv',
                          transactions: './spec/fixtures/mock_transactions.csv',})
    @sa = @se.analyst
  end

  it 'exists' do
    expect(@sa).to be_a(SalesAnalyst)
  end

  it 'finds the total revenue by date' do
    expect(@sa.total_revenue_by_date('2012-3-27')).to eq(2538467)
  end

end
