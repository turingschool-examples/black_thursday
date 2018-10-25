require './test/test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_returns_avg_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_returns_merchant_item_list
    merchant = @sales_analyst.merchants[4]
    item_list = @sales_analyst.merchant_item_list(merchant)
    assert_equal 25, item_list.count
  end

  def test_avg_items_per_merchant_std_dev
    std_dev = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.26, std_dev
  end

  def test_merchants_with_high_item_count
    skip
    @sales_analyst.merchants_with_high_item_count
    #[merchant, merchant, merchant]
    #merchants with more than one standard dev above avg item count
  end

  def test_avg_price_for_a_merchant
    skip
    #sales_analyst.average_item_price_for_merchant(12334159)
    #returns big decimal
  end

  def test_golden_items
    skip
    #sales_analyst.golden_items
    # => [<item>, <item>, <item>, <item>]
    #TWO standard devs above avg item price
  end

end
