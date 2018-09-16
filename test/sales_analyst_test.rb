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
      assert_equal 0.77, result # <= We're using fixtures here...!!!
      assert_equal Float, result.class
    end

    def test_it_returns_average_items_per_merchant_standard_deviation
      result = @sa.average_items_per_merchant_standard_deviation
      assert_equal Float, result.class
      assert_equal 0.39, result # <= We're using fixtures here...!!!
    end

    def test_it_can_return_which_merchants_sell_the_most_items
      result = @sa.merchant_with_high_item_count
      assert_instance_of Array,result
      assert_equal 3, result.count
    end

    def test_it_can_return_average_item_price_per_merchant
      result = @sa.average_item_price_per_merchant(12334105).to_f
      # assert_equal BigDecimal,result.class #Need to check BIG DECIMAL conversion
      assert_equal 2999.0,result
    end

    def test_it_returns_the_average_price_for_all_merchants
      result = @sa.average_average_price_per_merchant
      assert_equal 349.5,result
      assert_equal BigDecimal, result.class
    end

    
end
