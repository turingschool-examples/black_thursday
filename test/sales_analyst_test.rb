require './test/test_helper'
require 'bigdecimal'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv"
    })

    @SalesAnalyst = SalesAnalyst.new(se)
  end

  def test_an_instance_exists_and_takes_se
    assert_instance_of SalesAnalyst, @SalesAnalyst
  end

  def test_items_per_merchant_returns_float
    assert_equal 2.88, @SalesAnalyst.average_items_per_merchant
  end

  def test_standard_deviation_returns_std
    skip
    assert_equal 3.26, @SalesAnalyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_one_std_from_avg
    skip
    assert_equal [merchant, merchant, merchant], @SalesAnalyst.merchants_with_high_item_count
  end

  def test_average_price_for_merchant_returns_average_price_for_the_item
    average = @SalesAnalyst.average_item_price_for_merchant(12334159)
    expected = BigDecimal.new(2, 1)
    assert_equal expected, average
  end

  def test_average_average_price_per_merchant_sums_prices_across_all_merchants
    average_average = @SalesAnalyst.average_average_price_per_merchant
    expected = BigDecimal.new(2, 1)
    assert_equal expected, average_average
  end

  def test_golden_items_returns_items_2_standard_deviations_from_average
    skip
    # assert_equal [<item>, <item>, <item>, <item>], @SalesAnalyst.golden_items
  end

  def item_list
    [
      Item.new({
        id: 1,
        name: 'Apple',
        description: "One apple (a fruit, not a computer)",
        unit_price: BigDecimal.new(1.00, 3),
        merchant_id: 1
      }),
      Item.new({
        id: 2,
        name: 'Banana',
        description: "One banana (a fruit, not a clip)",
        unit_price: BigDecimal.new(0.50, 3),
        merchant_id: 2
      }),
      Item.new({
        id: 3,
        name: 'Cherry',
        description: "One cherry (a fruit, not a wood)",
        unit_price: BigDecimal.new(10000.00, 7),
        merchant_id: 2
      }),
      Item.new({
        id: 4,
        name: 'Durian',
        description: "A sweet thing with seeds",
        unit_price: BigDecimal.new(1.00, 3),
        merchant_id: 3
      })
    ]
  end

end
