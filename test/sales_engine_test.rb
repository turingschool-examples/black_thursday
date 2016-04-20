require './test/test_helper'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
  end

  def test_it_created_instance_of_sales_engine_class
    assert_equal SalesEngine, @se.class
  end

  def test_it_can_interact_with_merchants_class
    mr = @se.merchants
    puts mr.class
    merchant = mr.find_by_name("CJsDecor")
    assert_equal Merchant, merchant.class
  end

  def test_it_can_interact_with_items_class
    ir = @se.items
    item = ir.find_by_name("510+ RealPush Icon Set")
    assert_equal Item, item.class
  end

  def test_it_can_return_item_if_items_is_called_on_merchants
    skip
    mr = @se.merchants
    merchant = mr.find_by_id("12337411")
    item_instances = merchant.items
    assert_equal Item, item_instances[0].class
  end


  # # => [<item>, <item>, <item>]
  # item = se.items.find_by_id(20)
  # item.merchant
  # # => <merchant>


end
