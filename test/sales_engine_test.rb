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
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_returns_merchants
    assert_instance_of MerchantRepository, @se.merchants
  end

end
