require_relative 'test_helper'
require_relative '../lib/item_repository.rb'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_can_hold_items
    assert_instance_of Array, @item_repository.items
  end

  def test_it_holding_items
    assert_instance_of Item, @item_repository.items[0]
    assert_instance_of Item, @item_repository.items[25]
  end

  def test_it_can_return_items_using_all
    assert_instance_of Item, @item_repository.all[5]
    assert_instance_of Item, @item_repository.all[97]
  end
end
