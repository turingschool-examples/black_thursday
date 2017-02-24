require './test/test_helper'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
  :items     => "./data/items_test_data.csv",
  :merchants => "./data/merchants.csv",})
  end

  def test_it_exists
    assert_instance_of ItemRepository, @se.items
  end

  def test_can_make_new_items
    ir = @se.items
    assert_instance_of Item, ir.all.first
  end

  def test_returns_all_items
    ir = @se.items
    assert_equal 117, ir.all.count
  end

end
