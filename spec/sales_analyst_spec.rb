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

    expect(sales_analyst.diff_and_square(sales_analyst.item_amount, sales_analyst.average_items_per_merchant)).to eq([1,0,1])
  end

  it "gets the sum from #diff_and_square" do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.diff_and_square_sum(sales_analyst.item_amount, sales_analyst.average_items_per_merchant)).to eq(2)

  end

  it 'Divide the sum by the number of elements minus 1.' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.divide_diff_and_square_sum(sales_analyst.item_amount, sales_analyst.average_items_per_merchant)).to eq(1)
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

    expect(sales_analyst.merchants_with_high_item_count).to eq([sales_engine.merchants.all[-1]])
  end

  it 'finds the average price of a merchants items' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test2.csv',
      :merchants => './data/merchant_test2.csv'
      )
      sales_analyst = sales_engine.analyst

      expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(13.0)
      expect(sales_analyst.average_item_price_for_merchant(12334105)).to be_a(BigDecimal)
  end

  it 'sums all the averages, and find the average across all merchant' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
      sales_analyst = sales_engine.analyst

      expect(sales_analyst.average_average_price_per_merchant).to eq(13.67)
  end

  it 'returns average item price per merchant standard deviation' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test2.csv',
      :merchants => './data/merchant_test2.csv'
      )
      sales_analyst = sales_engine.analyst
      sales_analyst.all_merchant_prices

      expect(sales_analyst.average_item_price_std_dev).to eq(0.43)
  end

  it 'finds the item prices of a merchant by its id' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
      sales_analyst = sales_engine.analyst

      expect(sales_analyst.prices(12334105)).to eq([12.0, 13.0, 14.0])
  end

  it 'finds each merchants item prices' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
      sales_analyst = sales_engine.analyst
      # require 'pry' ;binding.pry
      expect(sales_analyst.all_merchant_prices).to eq([0.12e2, 0.13e2, 0.14e2, 0.14e2, 0.14e2, 0.14e2, 0.14e2, 0.14e2, 0.14e2, 0.14e2, 0.14e2, 0.14e2])
  end


  it 'returns golden items' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test.csv',
      :merchants => './data/merchant_test.csv'
      )
      sales_analyst = sales_engine.analyst
  end
end
