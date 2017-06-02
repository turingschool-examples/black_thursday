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

  def test_from_csv_takes_hashes
    data_files = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    }
    se = SalesEngine.from_csv(data_files)

    actual = data_files.class
    expected = Hash
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

end
