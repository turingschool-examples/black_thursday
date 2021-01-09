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
end