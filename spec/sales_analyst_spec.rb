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

  it '.average_items_per_merchant' do
    expect(@sa.average_items_per_merchant).to eq()
  end


end
