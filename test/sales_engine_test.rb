require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'csv'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_can_parse
    skip
    se = SalesEngine.new
    se.load_csv("./data/merchants_short.csv", :merchants)
    assert_equal 5, se.merchants.merchants.count
  end

  def test_class_method_working
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                                                                  })
    # assert_instance_of ItemRepository, se.items
    assert_instance_of SalesEngine, se
  end
end
