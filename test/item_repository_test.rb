require "minitest/pride"
require "minitest/autorun"
require "./lib/item_repository"

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repository = ItemRepository.new
    assert_instance_of ItemRepository, item_repository
  end
end
