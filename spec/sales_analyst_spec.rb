require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

RSpec.describe SalesAnalyst do
  it '#exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'can return the average num of items per merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    # require 'pry'; binding.pry
    sales_analyst = se.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'can return the average num of items per merchant standard deviation' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    # require 'pry'; binding.pry
    sales_analyst = se.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'can return the average item price for a specific merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq 31.50
  end

  it 'can return the average average price per merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    expect(sales_analyst.average_average_price_per_merchant).to eq 350.29
    expect(sales_analyst.average_average_price_per_merchant.class).to eq BigDecimal
  end
end
