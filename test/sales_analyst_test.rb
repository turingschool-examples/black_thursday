require './test/test_helper'
require './lib/sales_analyst'
require 'pry'

class SalesAnalystTest < Minitest::Test

    def setup
        item_path      = "./test/fixture_data/item_sa.csv"
        merchant_path  = "./test/fixture_data/merchant_sa.csv"
        path           = {item_data: item_path, merchant_data: merchant_path}
        sales_engine  = SalesEngine.from_csv(path)
        @sales_analyst = SalesAnalyst.new(sales_engine)
        @items_per_merchant = @sales_analyst.items_per_merchant
        @average = @sales_analyst.average_items_per_merchant
    end

    def test_it_exists
        assert_instance_of SalesAnalyst, @sales_analyst
    end

    def test_it_can_find_average_items_per_merchant
        assert_instance_of Array, @sales_analyst.items_per_merchant
        assert_equal [8, 2, 8, 0, 2], @items_per_merchant
        assert_equal 4, @average
    end

    def test_it_can_find_standard_deviation
        assert_equal 3.74, @sales_analyst.standard_deviation(@items_per_merchant, @average)
    end
end