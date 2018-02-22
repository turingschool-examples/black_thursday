require './test/test_helper'
require './lib/sales_engine'
require 'pry'

# Tests Sales Engine class
class SalesEngineTest < Minitest::Test
  def setup
    @sales_eng = SalesEngine.from_csv(
      items:     './data/sample_data/items.csv',
      merchants: './data/sample_data/merchants.csv',
      invoices: './data/sample_data/invoices.csv'
    )
  end

  def test_sales_engine_class_exists
    assert_instance_of SalesEngine, @sales_eng
  end

  def test_sales_engine_creates_instances_of_repositories
    assert_instance_of ItemRepository, @sales_eng.items
    assert_instance_of MerchantRepository, @sales_eng.merchants
  end

  def test_sales_engine_can_find_merchant_items
    merchant = @sales_eng.merchants.find_by_id(123_341_05)
    item_ids = [1, 2]

    (0...item_ids.length).each do |index|
      assert_equal item_ids[index], merchant.items[index].id
      assert_instance_of Item, merchant.items[index]
    end
  end

  def test_sales_engine_can_find_items_merchant
    item = @sales_eng.items.find_by_id(1)

    assert_instance_of Merchant, item.merchant
    assert_equal 123_341_05, item.merchant.id
  end
end
