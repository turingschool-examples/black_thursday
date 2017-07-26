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
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_average_items_per_merchant
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    salesanalyst = SalesAnalyst.new(salesengine)

    average_items = salesanalyst.average_items_per_merchant

    assert_equal 2.88, average_items
  end

  def test_average_items_per_merchant_standard_deviation
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    salesanalyst = SalesAnalyst.new(salesengine)

    standard_deviation = salesanalyst.average_items_per_merchant_standard_deviation

    assert_equal 3.26, standard_deviation
  end

  def test_merchants_with_high_item_count
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    salesanalyst = SalesAnalyst.new(salesengine)

    high_item_merchants = salesanalyst.merchants_with_high_item_count

    assert_instance_of Array, high_item_merchants
    assert_instance_of Merchant, high_item_merchants[0]
  end

  def test_average_item_price_for_merchant
    skip
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    salesanalyst = SalesAnalyst.new(salesengine)
    merchant_id = salesengine.merchants.id_repo.keys[0]

    average_merchant_price = salesanalyst.average_item_price_for_merchant(merchant_id)
    assert_equal ________, average_merchant_price
  end

  def test_average_price_per_merchant
    skip
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    salesanalyst = SalesAnalyst.new(salesengine)

    average_price = sales_analyst.average_price_per_merchant

    assert_equal _________, average_price
  end

  def test_golden_items
    skip
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    salesanalyst = SalesAnalyst.new(salesengine)

    golden_items = sales_analyst.golden_items

    assert_instance_of Array, golden_items
    assert_instance_of Item, golden_items[0]
  end
end
