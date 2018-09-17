require './test/minitest_helper'

class SalesAnalystTest < Minitest::Test

    def setup
     se = SalesEngine.from_csv({
     :merchants     => './test/fixtures/merchants_fixtures.csv',
     :items         => './test/fixtures/items_fixtures.csv'
                             })
     @sa = se.analyst
    end

    def test_it_exists
     assert_instance_of SalesAnalyst, @sa
    end

    def test_it_returns_average_items_per_merchant
      result = @sa.average_items_per_merchant
      assert_equal 0.77, result
      assert_equal Float, result.class
    end

    def test_it_returns_average_items_per_merchant_standard_deviation
      result = @sa.average_items_per_merchant_standard_deviation
      assert_equal Float, result.class
      assert_equal 0.98, result
    end

    def test_it_can_return_which_merchants_sell_the_most_items
      result = @sa.merchants_with_high_item_count
      assert_instance_of Array,result
      assert_equal 0, result.count
    end

    def test_it_can_return_average_item_price_per_merchant
      result = @sa.average_item_price_for_merchant(12334105)
      assert_instance_of BigDecimal,result
      assert_equal  0.2999e2,result
    end

    def test_it_returns_the_average_price_for_all_merchants
      result = @sa.average_average_price_per_merchant
      assert_instance_of BigDecimal, result
      assert_equal 0.5808e2,result
    end

    def test_item_price_std_dev
      result = @sa.item_price_std_dev
      assert_equal 124.97,result
    end

    def test_it_can_return_golden_items
      result = @sa.golden_items
      assert_instance_of Array, result
      assert_equal 1,result.count
      assert_equal 0.4e3, result.first.unit_price
    end
end
