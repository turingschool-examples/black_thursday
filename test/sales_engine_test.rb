require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })

    assert_instance_of SalesEngine, se
  end

  def test_it_hasa_readable_attrabutes
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })

    assert_equal CSV::Table, se.items.class
  end
end
