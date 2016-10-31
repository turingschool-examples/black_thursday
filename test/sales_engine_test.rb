gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require "minitest/nyan_cat"
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    assert SalesEngine
  end

  def test_it_grabs_two_csv_files
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_equal "", sales_engine.items 
  end

end