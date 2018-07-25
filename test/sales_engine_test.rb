require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require_relative './sales_engine'
require_relative './item_repository'
require_relative './merchant_repository'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    sales_engine= SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
     })
    assert_instance_of SalesEngine, sales_engine
  end
end
