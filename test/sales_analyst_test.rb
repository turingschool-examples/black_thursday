require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa

  def setup
    # se = SalesEngine.from_csv({items: })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end
end
