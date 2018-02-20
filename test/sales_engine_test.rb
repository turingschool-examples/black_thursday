require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_initializes
    sales_engine = SalesEngine.from_csv({
      items: './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants_fix.csv'
      })

    assert_instance_of SalesEngine, sales_engine
  end

  def test_sales_engine_has_merch_repo
    sales_engine = SalesEngine.from_csv({
      items: './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants_fix.csv'
      })
    merchant_repo = sales_engine.merchants
    merchant = merchant_repo.find_by_name('Shopin1901')

    assert_instance_of MerchantRepository, merchant_repo
    assert_instance_of Merchant, merchant
    assert_equal 12334105, merchant.id
    assert_equal 'Shopin1901', merchant.name
  end

  def test_sales_engine_has_item_repo
    sales_engine = SalesEngine.from_csv({
      items: './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants_fix.csv'
      })
    item_repo = sales_engine.items
    item = item_repo.find_by_name('Glitter scrabble frames')

    assert_instance_of ItemRepository, item_repo
    assert_instance_of Item, item
    assert_equal 263395617, item.id
    assert_equal 'Glitter scrabble frames', item.name
  end

  def test_merchant_items_returns_items_array
    sales_engine = SalesEngine.from_csv({
      items: './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants_fix.csv'
      })

    merchant = sales_engine.merchants.find_by_id(12334141)
    merchant.items
    
    assert_equal 1, merchant.items.count
    assert_equal "510+ RealPush Icon Set", merchant.items[0].name
  end

  def test_item_merchant_returns_merchant_instance
    sales_engine = SalesEngine.from_csv({
      items: './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants_fix.csv'
      })

    item = sales_engine.items.find_by_id(263395237)
    item.merchant

    assert_equal "jejum", item.merchant.name
  end
end
