require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
    })
  end

  def test_has_items_and_merchants
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_finds_merchant_by_merchant_id
    merchant = se.merchants.find_by_id(1000)
    assert_equal merchant, se.find_merchant_by_id(1000)
  end

  def test_finds_all_items_by_merchant_id
    items = se.items.find_all_by_merchant_id(1000)
    assert_equal items, se.find_all_items_by_merchant_id(1000)
  end

  def test_merchant_accesses_items
    merchant = se.merchants.find_by_id(1000)
    merchants_items = se.find_all_items_by_merchant_id(1000)
    assert_equal merchants_items, merchant.items
  end

  def test_item_accesses_merchant
    item = se.items.find_by_id(1)
    items_merchant = se.find_merchant_by_id(1000)
    assert_equal items_merchant, item.merchant
  end

  def test_method_total_merchants_returns_fixnum
    assert_equal se.merchants.all.length, se.total_merchants
  end

  
end
