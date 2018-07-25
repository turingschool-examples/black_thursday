require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative './sales_engine'

class SalesAnalystTest < Minitest::Test 
  def test_it_exists
    sales_analyst = SalesAnalyst.new  
    
    assert_instance_of SalesAnalyst, sales_analyst
  end 
  
  def test_it_exists
    sales_engine = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
     })
    sales_analyst = sales_engine.analyst 
    
    assert_instance_of SalesAnalyst, sales_analyst
  end
  
end 