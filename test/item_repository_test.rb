require './test/minitest_helper'
require './lib/item_repository'

class MerchantTest<Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_item_repo_has_items
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 1367 , ir.all.count
    assert_instance_of Array, ir.all
  end
end
