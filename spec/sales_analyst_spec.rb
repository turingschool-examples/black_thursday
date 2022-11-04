require_relative '../lib/sales_engine.rb'
require_relative '../lib/item_repository.rb'
# require './lib/item.rb'
# require './lib/merchant.rb'
# require './lib/merchant_repository.rb'
require_relative '../lib/sales_analyst'
require 'csv'

RSpec.describe SalesAnalyst do
  it 'exists' do
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'has a sales engine' do
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.engine).to be_a(SalesEngine)
  end

  it 'calculates the average items per merchant' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items.csv',
      :merchants => './data/merchants.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'Take the difference between each number and the mean, then square it.' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.diff_and_square).to eq([1,0,1])
  end

  it "gets the sum from #diff_and_square" do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.diff_and_square_sum).to eq(2)

  end

  it 'Divide the sum by the number of elements minus 1.' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.divide_diff_and_square_sum).to eq(1)
  end

  it 'returns the standard deviation' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(1.0)
  end
  it 'returns the standard deviation' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(1.0)
  end

  it 'returns the standard deviation' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(1.0)
  end

  xit 'returns the standard deviation' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items.csv',
      :merchants => './data/merchants.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'returns the merchants with high item counts' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test2.csv',
      :merchants => './data/merchant_test2.csv'
      )
    sales_analyst = sales_engine.analyst
    #mean 5.6 + 2.41 = 8.01...last merchant(9) items > 1 std dev from mean
    expect(sales_analyst.merchants_with_high_item_count).to eq([sales_engine.merchants.all[-1]])

  end
end
