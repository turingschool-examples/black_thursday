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
    ir.items
    assert_equal 1367, ir.all.count
  end

  def test_it_can_find_by_id
    ir = ItemRepository.new('./data/items.csv')
    ir.items
    assert_instance_of Item, ir.find_by_id('263399263')
  end

  def test_it_can_find_by_name
    ir = ItemRepository.new('./data/items.csv')
    ir.items
    assert_instance_of Item, ir.find_by_name('Oak Bowl')
  end

  def test_it_can_find_all_by_name
    ir = ItemRepository.new('./data/items.csv')
    ir.items
    assert_equal [], ir.find_all_by_name('AaronBrooksRoberts')
    assert_equal 1, ir.find_all_by_name('Oak').count
  end
end
