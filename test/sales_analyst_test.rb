require './test/test_helper'
require './lib/sales_analyst'
require 'pry'

class SalesAnalystTest < Minitest::Test

    def setup
        @sales_analyst = SalesAnalyst.new
    end

    def test_it_exists
        assert_instance_of SalesAnalyst, @sales_analyst
    end

    def test_sales_analyst_can_access_merchants
        
    end
end