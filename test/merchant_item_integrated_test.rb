require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class MerchantItemIntegratedTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => "./data_fixtures/items_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
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

  def test_item_knows_its_merchant
    item = sales_engine.items.find_by_id(263395237)
    merchant = item.merchant
    assert_equal item.merchant_id, merchant.id
  end
  
end