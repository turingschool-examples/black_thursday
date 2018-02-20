require './test/test_helper'
require './test/fixtures/mock_sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_sales_analyst_class_exists
    sales_eng = MockSalesEngine.new
    sales_a   = SalesAnalyst.new(sales_eng)
  end
end
