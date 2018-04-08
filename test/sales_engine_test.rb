require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require_relative '../lib/sales_engine'

class SalesEngineTest<Minitest::Test

  def test_it_exists
    se = SalesEngine.new({:items=> "./data/items.csv",:merchants => "./data/merchants.csv"})
    assert_instance_of SalesEngine, se
    require 'pry'; binding.pry
  end


end
