require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def test_it_exists
    se = SalesEngine.new(merchants:"./data/merchants.csv")

    assert_instance_of SalesEngine, se
  end

  def test_merchants_method
    se = SalesEngine.new(merchants:"./data/merchants.csv")

    assert_instance_of MerchantRepo, se.merchants
  end

  def test_items_method
    se = SalesEngine.new(merchants:"./data/merchants.csv")

    assert_instance_of ItemRepo, se.items
  end
end
