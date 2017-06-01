require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/sales_engine"
require "pry"

class SalesEngineTest < Minitest::Test
  def test_it_exists
    item_dummy = CSV.open './data/small_item_set.csv', headers: true, header_converters: :symbol
    merch_dummy = CSV.open './data/merchant_sample.csv', headers: true, header_converters: :symbol
    se = SalesEngine.new(item_dummy, merch_dummy)

    assert_instance_of SalesEngine, se
  end

  def test_from_csv_returns_instance_of_sales_engine
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    se = SalesEngine.from_csv(small_csv_paths)

    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_items_returns_item_repo_instance
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    se = SalesEngine.from_csv(small_csv_paths)

    assert_instance_of ItemRepository, se.items
  end

  def test_sales_engine_merchants_returns_merchant_repo_instance
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    se = SalesEngine.from_csv(small_csv_paths)

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_sales_engine_items_returns_all_item_instances
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    se = SalesEngine.from_csv(small_csv_paths)

    assert_equal 6, se.items.all.length
    assert_instance_of Item, se.items.all.sample
  end

  def test_sales_engine_merchants_returns_all_merchant_instances
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    se = SalesEngine.from_csv(small_csv_paths)

    assert_equal 5, se.merchants.all.length
    assert_instance_of Merchant, se.merchants.all.sample
  end

  def test_it_can_return_all_items_for_a_merchant
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    se = SalesEngine.from_csv(small_csv_paths)

    actual = se.all_merchant_items(12334213)

    assert_instance_of Array, actual
    assert_instance_of Item, actual.sample
    assert_equal 2, actual.count
    assert_equal 12334213, actual.sample.merchant_id
  end

  def test_it_can_get_merchant_by_item
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    se = SalesEngine.from_csv(small_csv_paths)

    actual = se.merchant_by_item(12334113)

    assert_instance_of Merchant, actual
    assert_equal 12334113, actual.id 
  end
end
