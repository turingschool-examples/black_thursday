require_relative "test_helper"
require "./lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_imports_from_csv
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_populates_all_array
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    assert_instance_of Array, se.items.all
    assert_equal 1367, se.items.all.count
    assert_equal 475, se.merchants.all.count
  end

  def test_it_can_find_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    merchant = se.merchants.find_by_id(12334112)
    assert_equal 3, merchant.items.count

  # item = se.items.find_by_id(263395237)
  # assert_equal [], item.merchant
  end

end
