require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'

class TestSalesAnalyst < MiniTest::Test

  def test_it_exists
    sa = SalesAnalyst.new
    assert_instance_of SalesAnalyst, sa
  end
end