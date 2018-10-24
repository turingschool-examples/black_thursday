require_relative './helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'
class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new('./data/items.csv')
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_create_items
    ir = ItemRepository.new('./data/items.csv')
    assert_equal 1367, ir.items.count
  end

  def test_it_can_return_array_of_all_items
    ir = ItemRepository.new('./data/items.csv')
    assert_equal 1367, ir.all.count
  end
end
