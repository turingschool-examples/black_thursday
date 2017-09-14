require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
# require "./lib/item_repository"
# require "./lib/merchant_repository"
# require "./lib/merchant"
# require "./lib/item"



class TestSalesAnalyst < Minitest::Test

  def test_its_exists
    se = "se"
    sa = SalesAnalyst.new(se)
    assert_instance_of SalesAnalyst, sa
  end


end
