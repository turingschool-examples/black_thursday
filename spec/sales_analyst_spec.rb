require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/sales_analyst'

RSpec.describe 'SalesAnalyst' do
  it 'exists' do
    mock_engine = double('Sales Engine')
    sales_analyst = SalesAnalyst.new([7, 8, 9, 10, 11], mock_engine)

    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'has a mean' do
    sales_analyst = SalesAnalyst.new([7, 8, 9, 10, 11], mock_engine)

    expect(sales_analyst.mean).to eq(9)
  end
end
