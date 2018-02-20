require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_initializes
    sales_engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
      })

    assert_instance_of SalesEngine, sales_engine
  end

  def test_sales_engine_has_merch_repo
    sales_engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
      })
    merchant_repo = sales_engine.merchants
    merchant = merchant_repo.find_by_name('CJsDecor')

    assert_instance_of MerchantRepository, merchant_repo
    assert_instance_of Merchant, merchant
    assert_equal 'CJsDecor', merchant.name
  end

  def test_sales_engine_has_item_repo
    sales_engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
      })
    item_repo = sales_engine.items
    item = item_repo.find_by_name('Glitter scrabble frames')

    assert_instance_of ItemRepository, item_repo
    assert_instance_of Item, item
    assert_equal 'Glitter scrabble frames', item.name
  end

  def test_merchant_items_returns_items_array
    sales_engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
      })

    merchant = sales_engine.merchants.find_by_id(12334112)

    merchant.items
    
    assert_equal 1, merchant.items.count
  end
end
