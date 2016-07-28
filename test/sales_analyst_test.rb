require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"

class SalesAnalystTest < Minitest::Test

  def test_it_can_calculate_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/support/merchant_support.csv",
      })
    sa = SalesAnalyst.new(se)
    assert_equal 13.67, sa.average_items_per_merchant
  end

  def test_we_have_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/support/merchant_support.csv",
      })
    sa = SalesAnalyst.new(se)
    assert_equal 1.2733829119334217, sa.standard_deviation_in_items_per_merchant
  end

  def test_it_can_find_merchants_with_most_items
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/support/merchant_support.csv",
      })
    sa = SalesAnalyst.new(se)
    assert_equal 2, sa.merchants_with_high_item_count.count
  end

  def test_it_can_find_the_average_price_for_a_merchant_with_one_item
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/support/merchant_support.csv",
      })
    sa = SalesAnalyst.new(se)
    assert_equal 4995.0, sa.average_item_price_for_merchant(12334303).to_f
  end

  def test_it_can_find_the_average_price_for_a_merchant_with_multiple_items
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/support/merchant_support.csv",
      })
    sa = SalesAnalyst.new(se)
    assert_equal 48335.0, sa.average_item_price_for_merchant(12334195).to_f
  end

end
