require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/sales_analyst'

RSpec.describe 'SalesAnalyst' do
  it 'exists' do
    mock_engine = double('Sales Engine')
    sales_analyst = SalesAnalyst.new(mock_engine)

    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'has a mean' do
    mock_engine = double('Sales Engine')
    sales_analyst_1 = SalesAnalyst.new(mock_engine)
    sales_analyst_2 = SalesAnalyst.new(mock_engine)


    expect(sales_analyst_1.mean).to eq(9)
    expect(sales_analyst_2.mean).to eq(25.5)
  end

  it 'can calculate standard deviation' do
    mock_engine = double('Sales Engine')
    sales_analyst_1 = SalesAnalyst.new([7, 8, 9, 10, 11], mock_engine)
    sales_analyst_2 = SalesAnalyst.new([2, 45, 23, 32], mock_engine)

    expect(sales_analyst_1.standard_deviation).to eq(1.58)
    expect(sales_analyst_2.standard_deviation).to eq(18.08)
  end
end
