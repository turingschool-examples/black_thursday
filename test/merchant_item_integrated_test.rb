require_relative 'test_helper'
require_relative '../lib/sales_engine'

class MerchantItemIntegratedTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => "./test/data_fixtures/items_fixture.csv",
      :merchants => "./test/data_fixtures/merchants_fixture.csv"
    })
  end

  def test_merchant_knows_its_one_item
    merchant = sales_engine.merchants.find_by_id(12334141)
    items = merchant.items
    assert_equal 1, items.length
    assert items.one? {|item| item.id == 263395237}
  end

  def test_merchant_knows_all_its_items
    merchant = sales_engine.merchants.find_by_id(12334195)
    items = merchant.items
    assert_equal 10, items.length
  end

  def test_merchant_without_item_returns_nil
     merchant = sales_engine.merchants.find_by_id(12334176)
     items = merchant.items
     assert [], items
  end

  def test_item_knows_its_merchant
    item = sales_engine.items.find_by_id(263395237)
    merchant = item.merchant
    assert_equal item.merchant_id, merchant.id
  end

  def test_item_without_merchant_returns_nil
    item = sales_engine.items.find_by_id(263398079)
    merchant = item.merchant
  end
  
end