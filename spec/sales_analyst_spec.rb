require_relative '../lib/sales_analyst'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require 'csv'
require 'bigdecimal'

RSpec.describe SalesAnalyst do
  before(:each) do
    @se = SalesEngine.new({items:       './spec/fixtures/mock_items.csv',
                          merchants:    './spec/fixtures/mock_merchants.csv',
                          invoices:     './spec/fixtures/mock_invoices.csv',
                          invoice_items: './spec/fixtures/mock_invoice_items.csv',
                          transactions: './spec/fixtures/mock_transactions.csv',
                          customers:    './spec/fixtures/mock_customers.csv'})

    @sa = @se.analyst
  end

  it 'exists' do
    expect(@sa).to be_a(SalesAnalyst)
  end

  it 'calculates average invoice per merchant' do
    expect(@sa.average_invoices_per_merchant).to eq(1.09)
  end

  it 'calculates the average invoice per merchant standard deviation' do
    expect(@sa.average_invoices_per_merchant_standard_deviation).to eq(0.28)
  end

  it 'returns top merchants by invoice count' do
    expected = @sa.top_merchants_by_invoice_count

    expect(expected.length).to eq(4)
  end

  it 'returns bottom merchants bu invoice count' do
    expected = @sa.bottom_merchants_by_invoice_count

    expect(expected.length).to eq(0)
  end

  it 'returns average invoice per day' do
    expect(@sa.average_invoice_per_day).to eq(7.14)
  end

  it 'returns the average invoice per day standard deviation' do
    expect(@sa.average_invoice_per_day_standard_deviation).to eq(3.48)
  end

  it 'returns the top days by invoice count' do
    expected = @sa.top_days_by_invoice_count

    expect(expected.length).to eq(1)
  end

  it 'returns total invoice by merchant' do
    expect(@sa.invoice_status(:shipped)).to eq(60.0)
  end

end
