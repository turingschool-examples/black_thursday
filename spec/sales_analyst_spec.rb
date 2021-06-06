require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/sales_analyst'

RSpec.describe 'SalesAnalyst' do
  it 'exists' do
    mock_engine = double('Sales Engine')
    sa = SalesAnalyst.new(mock_engine)

    expect(sa).to be_a(SalesAnalyst)
  end

  it 'has an average' do
    mock_engine = double('Sales Engine')
    sa_1 = SalesAnalyst.new(mock_engine)
    sa_2 = SalesAnalyst.new(mock_engine)
    sa_3 = SalesAnalyst.new(mock_engine)

    expect(sa_1.average([7, 8, 9, 10, 11])).to eq(9)
    expect(sa_2.average([2, 45, 23, 32])).to eq(25.5)
    expect(sa_3.average([5, 7, 9, 4, 4])).to eq(5.8)
  end

  it 'can calculate standard deviation' do
    mock_engine = double('Sales Engine')
    sa_1 = SalesAnalyst.new(mock_engine)
    sa_2 = SalesAnalyst.new(mock_engine)
    sa_3 = SalesAnalyst.new(mock_engine)


    expect(sa_1.standard_deviation([7, 8, 9, 10, 11])).to eq(1.58)
    expect(sa_2.standard_deviation([2, 45, 23, 32])).to eq(18.08)
    expect(sa_3.standard_deviation([5, 7, 9, 4, 4])).to eq(2.17)
  end

  it 'can calculate the number of items per merchant' do
    se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv'
      })
    sa_1 = SalesAnalyst.new(se)

    expect(sa_1.items_per_merchant).to eq([5, 7, 9, 4, 4])
  end

  it 'can calculate average items per merchant' do
    se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv'
      })
    sa_1 = SalesAnalyst.new(se)

    expect(sa_1.average_items_per_merchant).to eq(5.8)
  end

  it 'can calculate average items per merchant standard deviation' do
    se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv'
      })
    sa_1 = SalesAnalyst.new(se)

    expect(sa_1.average_items_per_merchant_standard_deviation).to eq(2.17)
  end

  it 'can calculate merchants with a high item count' do
    se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv'
      })
    sa_1 = SalesAnalyst.new(se)

    expect(sa_1.merchants_with_high_item_count.count).to eq(1)
  end

  it 'can determine the average item price per merchant' do
    se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv'
      })
    sa_1 = SalesAnalyst.new(se)

    expect(sa_1.average_item_price_for_merchant(12334123)).to eq(0.11e3)
  end

  it 'can calculate the average of the averages per merchant' do
    se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv'
      })
    sa_1 = SalesAnalyst.new(se)

    expect(sa_1.average_average_price_per_merchant).to eq(0.3735e2)
  end

  it 'can calculate the golden items which are 2 standevs above mean' do
    se = SalesEngine.from_csv({
      :items => './spec/fixtures/item_mock.csv',
      :merchants => './spec/fixtures/merchant_mock.csv'
      })
    sa_1 = SalesAnalyst.new(se)

    expect(sa_1.golden_items.count).to eq(2)
  end
end
