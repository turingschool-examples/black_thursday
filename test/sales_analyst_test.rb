require './test/minitest_helper'
require './lib/sales_analyst'
require './lib/sales_engine'
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

 end
