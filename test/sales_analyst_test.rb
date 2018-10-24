require_relative './test_helper'

class SalesAnalystTest < Minitest::Test
  
  def setup
    @sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
  end
  
  def test_it_exists
    sales_analyst = SalesAnalyst.new
    assert_instance_of SalesAnalyst, sales_analyst
  end
  
  def test_it_can_be_created_by_sales_engine
      sales_analyst = @sales_engine.analyst
      assert_instance_of SalesAnalyst, sales_analyst
  end
  
end
