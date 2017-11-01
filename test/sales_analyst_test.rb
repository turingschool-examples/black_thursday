require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_it_exists
    sa = SalesAnalyst.new

    assert_instance_of SalesAnalyst, sa
  end
end
