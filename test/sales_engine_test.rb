require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/data/items_truncated.csv",
      :merchants => "./test/data/merchants_truncated.csv"
    })
  end
  
  def test_that_sales_engine_is_right_class
    assert_equal SalesEngine, @se.class
  end

  def test_from_csv_returns_sales_engine
    assert_equal SalesEngine, @se.class
  end

  def test_items_creates_instance_of_item_repository
      assert_instance_of ItemRepository, @se.items
  end

  def test_merchants_creates_instance_of_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_sales_engine_can_access_merch_repo_methods
    actual = @se.merchants.find_by_id(12334105)
    expected = @se.merchants.all[0]

    assert_equal expected, actual
  end

  def test_sales_engine_can_access_array_of_items
    actual = @se.items.find_all_by_merchant_id(12334105)

    assert_equal Array, actual.class
  end

  def test_if_merchant_method_links_to_item_class
    skip
    actual = @se.merchant
    expected = "1234"

    assert_equal expected, actual
  end
end
