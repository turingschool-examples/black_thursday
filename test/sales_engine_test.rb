require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    assert_instance_of SalesEngine, SalesEngine.new
  end

  def test_it_can_open_from_csv
    SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
    })
  end
end
