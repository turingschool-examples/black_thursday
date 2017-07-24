require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => '/data/merchants.csv'})
    # se will return an instance of SalesEngine
    assert_instance_of SalesEngine, se
  end

  def test_it_can_load_items
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => '/data/merchants.csv'})

    assert_equal 263395237, se.ir.array[0].id
  end

end