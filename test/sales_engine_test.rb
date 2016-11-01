require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  def test_it_exists
    assert SalesEngine
  end

  def test_it_intitalizes_an_item_repo_object
    SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal ItemRepository, SalesEngine.items.class
  end

  def test_it_grabs_items_csv_file
    skip
    SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal "./data/items.csv", SalesEngine.items 
  end

  def test_it_grabs_merchants_csv_file
    skip
    SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal "./data/merchants.csv", SalesEngine.merchants 
  end

end
