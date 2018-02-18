require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_class_exists
    sales_eng = SalesEngine.from_csv({
      :items     => "./data/sample_data/items.csv",
      :merchants => "./data/sample_data/merchants.csv",})

    assert_instance_of SalesEngine, sales_eng
  end
end
