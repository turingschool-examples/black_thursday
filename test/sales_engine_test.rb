require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({items: "./data/item_fixtures.csv",
                            merchants: "./data/merchant_fixtures.csv",
                             invoices: "./data/invoice_fixtures.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end

  def test_engine_can_find_merchant_by_name
    mr = se.merchants
    merchant = mr.find_by_name("MiniatureBikez")
    assert_instance_of Merchant, merchant
    assert_equal "MiniatureBikez", merchant.name
  end

  def test_engine_can_find_item_by_name
    ir   = se.items
    item = ir.find_by_name("Glitter scrabble frames")
    assert_instance_of Item, item
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_it_can_find_all_items_of_particular_merchant
    merchant = se.merchants.find_by_id(12334185)
    assert_equal 1, merchant.items.count
  end

  def test_it_can_find_merchant_by_item_id
    item = se.items.find_by_id(263395237)
    item.stubs(:find_by_id).returns(Merchant)
    assert_instance_of Merchant, item.merchant
  end
end
