require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'

class TestSalesAnalyst < MiniTest::Test

  def setup
    @sales_analyst = SalesAnalyst.new
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
    assert_instance_of Float, @sales_analyst.average_items_per_merchant
  end
end