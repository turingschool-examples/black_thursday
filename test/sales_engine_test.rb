require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_does_it_exist
    files_to_be_loaded = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      }
    se = SalesEngine.new(files_to_be_loaded)
    assert_instance_of SalesEngine, se
  end

  def test_has_method_that_takes_hash_of_things_and_returns_a_sales_engine
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    assert_instance_of SalesEngine, se
  end

  def test_merchants_returns_a_Merchant_Repository
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_can_return_items_of_a_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    merchant = se.merchants.find_by_id(12334112)
    merchant_items = merchant.items

    assert_equal 1, merchant_items.count
    assert_instance_of Item, merchant_items.first
    assert_instance_of Array, merchant_items
  end

  def test_it_can_return_merchant_of_item
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })

    item = se.items.find_by_id(263395237)
    merchant_item = item.merchant

    assert_equal
    assert_instance_of Merchant, merchant_item
  end
end
