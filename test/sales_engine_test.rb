require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_can_initialize_with_IR_and_MR_instances
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_facilitate_bidirectional_lookups_bet_mercs_and_items
      se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchant = se.merchants.find_by_id(12334155)
    # =>
    merchant.items
    # => [<item>, <item>, <item>]
    item = se.items.find_by_id(263395237)
    item.merchant
    # => <merchant>
  end

  def test_can_find_merchant_by_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchant = se.merchants.find_by_id(12334155)
    assert_equal merchant, se.find_merchant_by_id(12334155)
  end

  def test_can_find_all_items_by_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    items = se.items.find_all_by_merchant_id(12334155)
    assert_equal items, se.find_all_items_by_merchant_id(12334155)
  end
end
