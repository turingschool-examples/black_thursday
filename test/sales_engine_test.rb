require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
  end

  def test_it_exist_with_attributes
    assert_instance_of SalesEngine, @se

    assert_equal "./data/items.csv", @se.items
    assert_equal "./data/merchants.csv", @se.merchants
  end
end