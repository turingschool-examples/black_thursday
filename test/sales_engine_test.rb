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
    merchant = se.merchants.find_by_id(10)
    # =>
    merchant.items
    # => [<item>, <item>, <item>]
    item = se.items.find_by_id(20)
    item.merchant
    # => <merchant>
  end
end
