require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engline'

# Test for the SalesAnalyst class
class SalesAnalystTest < Minitest::Test
  def setup
    @sales_analyst = SalesAnalyst.new
  end

  def test_sales_analyst_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end
end
