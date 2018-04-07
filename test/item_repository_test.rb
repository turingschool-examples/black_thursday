require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_exists
    item_repo = ItemRepository.new('./test/items.csv')
    assert_instance_of ItemRepository, item_repo
  end

  def test_can_load_item
    item_repo = ItemRepository.new('./test/items.csv')
    assert_instance_of Array, item_repo.items
    assert_equal 263395237, item_repo.items.first.id
    assert_equal "2016-01-11 09:34:06 UTC", item_repo.items.first.created_at
  end
end
