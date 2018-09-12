require_relative './test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def test_it_exists
    sales_analyst = SalesAnalyst.new

    assert_instance_of SalesAnalyst, sales_analyst
  end



end
