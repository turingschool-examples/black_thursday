require 'minitest/autorun'
require 'minitest/pride'

require './lib/item_repo'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repository = ItemRepository.new
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_returns_all_items
    assert_equal 1367, @item_repository.all
  end

  def test_it_can_find_by_id
    id = 263538760
  end

end
