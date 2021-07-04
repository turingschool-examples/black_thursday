require_relative "test_helper"
require_relative "../lib/sales_engine"


class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end

  def test_imports_from_csv
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_populates_all_array
    assert_instance_of Array, se.items.all
    assert_equal 1367, se.items.all.count
    assert_equal 475, se.merchants.all.count
  end

  def test_it_can_find_by_id
    merchant = se.merchants.find_by_id(12334112)
    assert_equal 1, merchant.items.count
  end

  def test_matches_correct_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    item = se.items.find_by_id(263395237)
    item.merchant

    assert_instance_of Merchant, item.merchant
    # merchant = se.merchants.all.last
    #
    # item = merchant.items.first
    # assert_equal merchant, item.merchant
  end

end
