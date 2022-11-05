require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'

class SalesEngineTest < Minitest::Test

  def test_engine_exists
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })

    assert_instance_of SalesEngine, se
  end
end
