require 'minitest/autorun'
require 'minitest/emoji'
require './lib/itemrepository'
class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  def test_access_item_instance
    ir = ItemRepository.new

    assert_nil ir.item
  end

  def test_find_all_known_item_instances
    ir = ItemRepository.new

    assert_equal [], ir.all
  end
end
