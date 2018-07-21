require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_repo = ItemRepository.new('./data/items.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_it_has_somewhere_to_store_items
    assert_instance_of Array, @item_repo.items
  end

  def test_it_can_load_items_from_csv
    refute @item_repo.items.empty?
  end

  def test_it_can_return_all_items
    assert_equal @item_repo.items, @item_repo.all
  end 
end
