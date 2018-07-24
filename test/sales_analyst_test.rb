require_relative './test_helper'
require './lib/sales_analyst'
require './sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    sa = SalesAnalyst.new

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_create_instance_of_sales_engine
    sa = SalesAnalyst.new

    assert_equal SalesEngine, sa.sales_engine
  end
end
