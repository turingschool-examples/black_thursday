# sa = SalesAnalyst.new(sales_engine)
# sa.average_items_per_merchant
# sa.average_items_per_merchant_standard_deviation
#     Take the difference between each number and the mean and square it
#     Sum these square differences together
#     Divide the sum by the number of elements minus 1
#     Take the square root of this result
# sa.merchants_with_high_item_count # => [merchant, merchant, merchant]
# sa.average_item_price_for_merchant(merchant_id) # => BigDecimal
# sa.average_average_price_per_merchant # => BigDecimal
# sa.golden_items # => [<item>, <item>, <item>, <item>]
#     ^2 standard deviations above average price
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    average_items = sales_analyst.average_items_per_merchant

    assert_equal 2.88, average_items
  end

  def test_average_items_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    standard_deviation = sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal 3.26, standard_deviation
  end

  def test_merchants_with_high_item_count
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    high_item_merchants = sales_analyst.merchants_with_high_item_count

    assert_instance_of Array, high_item_merchants
    assert_instance_of Merchant, high_item_merchants[0]
  end

  def test_average_item_price_for_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(sales_engine)
    merchant_id = 12334105

    average_item_price = sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal 1665.67, average_item_price
  end

  def test_average_price_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    average_price = sales_analyst.average_price_per_merchant

    assert_equal _________, average_price
  end

  def test_golden_items
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    golden_items = sales_analyst.golden_items

    assert_instance_of Array, golden_items
    assert_instance_of Item, golden_items[0]
  end
end
