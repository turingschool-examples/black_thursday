require_relative "../test/test_helper"
require_relative "../lib/sales_engine"


class SalesEngineTest < Minitest::Test

  def test_it_exists
    sales_engine = SalesEngine.new
    
    assert_instance_of SalesEngine, sales_engine
  end  
  
  def test_from_csv
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",})
  
    assert_instance_of CSV, sales_engine
  end
  
end