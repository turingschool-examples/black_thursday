require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'

class SalesEngineTest < Minitest::Test

  def test_engine_exists
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })

    assert_instance_of SalesEngine, se
  end


  def test_we_can_match_items_to_merchant
    sales_engine = SalesEngine.from_csv({
    :items     => "./fixtures/items_sample.csv",
    :merchants => "./fixtures/merchant_sample.csv",
    })

    ir = sales_engine.items
    merchant = sales_engine.find_merchant_by_merchant_id(12334195)
    expected = [merchant]
    assert_equal 1, expected.count
  end

  def test_we_can_get_all_items_by_merchant_id
    sales_engine = SalesEngine.from_csv({
    :items     => "./fixtures/items_sample.csv",
    :merchants => "./fixtures/merchant_sample.csv",
    })

    mr = sales_engine.merchants
    found_items = sales_engine.find_items_by_id(12334195)
    assert_equal 3, found_items.count
  end
end
