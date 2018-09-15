require_relative '../test/minitest_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

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

    def test_average_items_per_merchant_standard_deviation
      result = @sa.average_items_per_merchant_standard_deviation#({"12334141"=>1, "12334185"=>3, "12334105"=>1, "12334195"=>3, "12334213"=>2})
      assert_equal Float, result.class
      assert_equal 0.39, result
    end

    def test_it_can_return_which_merchants_sell_the_most_items
      result = @sa.merchant_with_high_item_count
      assert_instance_of Array,result
      assert_equal 3, result.count
    end
 end
