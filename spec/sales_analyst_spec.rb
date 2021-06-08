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

  it 'returns total invoice by merchant' do
    expect(@sa.invoice_status(:shipped)).to eq(60.0)
  end

  it '.average_items_per_merchant' do
    expect(@sa.average_items_per_merchant).to eq(2.08)
  end

  it '.average_items_per_merchant_standard_deviation' do
    expect(@sa.average_items_per_merchant_standard_deviation).to eq(2.34)
  end

  it '.merchants_with_high_item_count' do
    merchant_ids = []
    @sa.merchants_with_high_item_count.each do |merchant|
      merchant_ids << merchant.id
    end

    expect(merchant_ids).to eq([12334195])
  end

  it 'average_item_price_for_merchant' do
    expect(@sa.average_item_price_for_merchant(12334195)).to eq(0.44983e3)
  end

  it '.average_average_price_per_merchant' do
    expect(@sa.average_average_price_per_merchant.to_f).to eq(90.74)
  end

  it '.average_item_price' do
    expect(@sa.average_item_price).to eq(0.1536686e3)
  end

  it 'item_price_standard_deviation' do
    expect(@sa.item_price_standard_deviation).to eq(204.83)
  end

  it '.golden_items' do
    items = []
    @sa.golden_items.each do |item|
      items << item.id
    end

    expect(items).to eq([263397313, 263397785, 263398653, 263399263, 263400013])
  end
end
