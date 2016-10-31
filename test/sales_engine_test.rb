gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require "minitest/nyan_cat"
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    assert SalesEngine
  end

  def test_it_grabs_items_csv_file
    SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal "./data/items.csv", SalesEngine.items 
  end

  def test_it_grabs_merchants_csv_file
    SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal "./data/merchants.csv", SalesEngine.merchants 
  end

end