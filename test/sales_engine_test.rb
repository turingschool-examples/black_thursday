require_relative './helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'csv'
class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv( {
        :items      => "./data/items.csv",
        :merchants  => "./data/merchants.csv"
                                } )
    assert_instance_of SalesEngine, se
  end

  def test_it_can_create_items
    se = SalesEngine.from_csv( {
        :items      => "./data/items.csv",
        :merchants  => "./data/merchants.csv"
                                } )
    assert_instance_of Item, se.create_items[2]
  end

  def test_it_can_create_merchants
    se = SalesEngine.from_csv( {
        :items      => "./data/items.csv",
        :merchants  => "./data/merchants.csv"
                                } )
    assert_instance_of Merchant, se.create_merchants[2]
  end

  def test_it_can_create_an_item_repository
    se = SalesEngine.from_csv( {
        :items      => "./data/items.csv",
        :merchants  => "./data/merchants.csv"
                                } )
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_create_an_merchant_repository
    se = SalesEngine.from_csv( {
        :items      => "./data/items.csv",
        :merchants  => "./data/merchants.csv"
                                } )
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_big_decimal_converts_appropriately
    se = SalesEngine.from_csv( {
        :items      => "./data/items.csv",
        :merchants  => "./data/merchants.csv"
                                } )
    assert_instance_of BigDecimal, se.big_decimal_converter('200000')
    assert_equal 2000.00, se.big_decimal_converter('200000')
  end
end
