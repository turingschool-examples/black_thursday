require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_that_sales_engine_is_right_class
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    assert_equal SalesEngine, se.class
  end

  def test_from_csv_returns_sales_engine
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    assert_equal SalesEngine, se.class
  end

  def test_items_creates_instance_of_item_repository
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      item = se.items

      assert_instance_of ItemRepository, item
  end

  def test_merchants_creates_instance_of_merchant_repository
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    merch = se.merchants

    assert_instance_of MerchantRepository, merch
  end

  def test_sales_engine_can_access_merch_repo_methods
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    actual = se.merchants.find_by_id(12334105)
    expected = se.merchants.all[0]

    assert_equal expected, actual
  end

  def test_sales_engine_can_access_array_of_items
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    actual = se.items.find_all_by_merchant_id(12334105)

    assert_equal Array, actual.class
  end
end
