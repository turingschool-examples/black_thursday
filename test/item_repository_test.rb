require './test/test_helper'
require './lib/item_repository'


class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of ItemRepository, ir
  end

  def test_it_has_items
    ir = ItemRepository.new("./data/items.csv")
    assert_equal 1367, ir.all.count

    assert_equal "263395237", ir.all.first.id
  end

end
