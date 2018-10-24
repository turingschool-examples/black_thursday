require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    	  :items     => "./data/items.csv",
    	  :merchants => "./data/merchants.csv",
    	})
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_returns_items
    skip
  end

  def test_it_returns_merchants
    skip
  end

end
