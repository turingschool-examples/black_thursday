require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_item_repository_class_exists
    item_repo = ItemRepository.new('./data/sample_data/items.csv')

    assert_instance_of ItemRepository, item_repo
  end

  def test_item_repository_creates_multiple_items
    item_repo = ItemRepository.new('./data/sample_data/items.csv')

    assert_instance_of Item, item_repo.items[0]
    assert_instance_of Item, item_repo.items[-1]
  end
end
