require_relative 'test_helper'
require_relative  '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new
  end

  def test_it_loads_merchants_from_small_file
    sales_engine.from_file({:items => './test/small_items.csv', :merchants => './test/small_merchants.csv'})
    
    assert_equal 10, sales_engine.merchants.all.count
  end

  def test_it_loads_merchants_from_small_file_and_are_accessible_by_id
    sales_engine.from_file({:items => './test/small_items.csv', :merchants => './test/small_merchants.csv'})
    
    assert_equal "Shopin1901", sales_engine.merchants.find_by_id(12334105).name
  end

  def test_it_loads_merchants_from_small_file_and_are_accessible_by_id
    sales_engine.from_file({:items => './test/small_items.csv', :merchants => './test/small_merchants.csv'})
    
    assert_equal 12334105, sales_engine.merchants.find_by_name("Shopin1901").id
  end

  def test_it_loads_items_from_small_file
    sales_engine.from_file({:items => './test/small_items.csv', :merchants => './test/small_merchants.csv'})
    
    assert_equal 10, sales_engine.items.all.count
  end

  def test_it_loads_items_from_small_file_and_can_access_by_updated_at
    sales_engine.from_file({:items => './test/small_items.csv', :merchants => './test/small_merchants.csv'})
    
    assert_equal 2016, sales_engine.items.all[0].updated_at.year
  end

  def test_it_loads_items_from_small_file_and_can_access_by_price
    sales_engine.from_file({:items => './test/small_items.csv', :merchants => './test/small_merchants.csv'})
    
    assert_equal 263395721, sales_engine.items.find_all_by_price(13.50)[0].id
  end

  def test_it_loads_items_from_small_file_and_can_access_by_description
    sales_engine.from_file({:items => './test/small_items.csv', :merchants => './test/small_merchants.csv'})
    
    assert_equal 263395237, sales_engine.items.find_all_by_description("photobucket")[0].id
  end

end