require_relative '../lib/sales_analyst'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require 'csv'

RSpec.describe SalesAnalyst do
  before(:each) do
    @sa = SalesAnalyst.new
  end

  it 'exists' do
    expect(@sa).to be_a(SalesAnalyst)
  end

  it 'finds the total revenue by date' do
    @ii_repo = InvoiceItemRepository.new('./spec/fixtures/mock_analyst_invoice_items.csv')
    expect(@sa.total_revenue_by_date('2012-3-27')).to eq(2538467)
  end

end
