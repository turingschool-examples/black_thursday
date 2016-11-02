require_relative 'test_helper'
require_relative  '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({:items => './test/assets/small_items.csv', :merchants => './test/assets/small_merchants.csv'})
    sales_engine.merchants
    sales_engine.items
  end

  def test_it_loads_merchants_from_small_file
    assert_equal 10, sales_engine.merchants.all.count
  end

  def test_it_loads_merchants_from_small_file_and_are_accessible_by_id
    assert_equal "Shopin1901", sales_engine.merchants.find_by_id(12334105).name
  end

  def test_it_loads_merchants_from_small_file_and_are_accessible_by_id
    assert_equal 12334105, sales_engine.merchants.find_by_name("Shopin1901").id
  end

  def test_it_loads_items_from_small_file
    assert_equal 10, sales_engine.items.all.count
  end

  def test_it_loads_items_from_small_file_and_can_access_by_updated_at
    assert_equal 2007, sales_engine.items.all[0].updated_at.year
  end

  def test_it_loads_items_from_small_file_and_can_access_by_price
    assert_equal 263395721, sales_engine.items.find_all_by_price(13.50)[0].id
  end

  def test_it_loads_items_from_small_file_and_can_access_with_description
    assert_equal 263395237, sales_engine.items.find_all_with_description("photobucket")[0].id
  end

  def test_it_returns_array_of_items_given_id
    result = sales_engine.find_items_by_merchant_id(12334185)[0].name
    assert_equal "Glitter scrabble frames", result
  end

  def test_it_returns_merchant_instance_given_merchant_id
    result = sales_engine.find_merchant_by_merchant_id(12334112)
    assert_equal "Candisart", result.name
  end

end