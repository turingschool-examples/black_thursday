require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def test_creates_instance_of_item_repository
    se = SalesEngine.new

    assert_instance_of ItemRepository, se.items
  end

  def test_creates_instance_of_merchant_repository
    se = SalesEngine.new

    assert_instance_of MerchantRepository, se.merchants
  end


end
