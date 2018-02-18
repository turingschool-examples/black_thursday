require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_item_repository_class_exists
    item_repo = ItemRepository.new("./data/sample_data/items.csv")

    assert_instance_of ItemRepository, item_repo
  end
end
