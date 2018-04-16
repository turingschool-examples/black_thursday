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
        assert_equal 3.74, @sales_analyst.average_items_per_merchant_standard_deviation
    end

    def test_it_can_find_top_selling_merchants
        # merchants = @sales_analyst.merchants_with_high_item_count
        # sorted_merchants = merchants.sort_by do |merchant|
        #     merchant.items
        # end
        # sorted_merchants.map do |merchant|

        # end
        assert_instance_of Array, @sales_analyst.merchants_with_high_item_count
        assert_instance_of Merchant, @sales_analyst.merchants_with_high_item_count[0]
    end

    def test_it_can_find_average_price_for_merchant
        assert_equal 17.125, @sales_analyst.average_item_price_for_merchant(12334105)
    end

    def test_it_can_find_average_average_price_per_merchant
        assert_equal 54.425, @sales_analyst.average_average_price_per_merchant
    end

    def test_it_can_find_golden_items
        assert_instance_of Array, @sales_analyst.golden_items
        assert_instance_of Item, @sales_analyst.golden_items[0]
        sorted_golden_items = @sales_analyst.golden_items
        actual_1 = sorted_golden_items.map {|item| item.price}
        expected_1 = [650.0, 650.0, 600.0,
                      600.0, 600.0, 600.0, 
                      600.0, 600.0, 600.0, 
                      600.0, 550.0, 550.0]
        assert_equal expected_1, actual_1
    end

end