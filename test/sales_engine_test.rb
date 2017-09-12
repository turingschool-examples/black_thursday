require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    sales = SalesEngine.new

    assert_instance_of SalesEngine, sales
  end

  def test_from_csv
    sales = SalesEngine
    assert_instance_of Item, sales.read_items_file
  end

  def test_from_csv
    sales = SalesEngine
    assert_instance_of Merchant, sales.read_merchants_file
  end

end
