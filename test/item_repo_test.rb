require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require './lib/cleaner'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repository = ItemRepository.new
    @cleaner = Cleaner.new
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_returns_all_items
    assert_equal 1367, @item_repository.all.length
  end

  def test_it_can_find_by_id
    # require 'pry'; binding.pry
      assert_equal 263538760, @item_repository.find_item_by_id(263538760).id
      assert_equal "Puppy blankie", @item_repository.find_item_by_id(263538760).name
      assert_equal nil, @item_repository.find_item_by_id(1)
  end

  def test_item_objects
    csv = (@cleaner.open_csv('./data/items.csv'))
    assert_equal 1367, @item_repository.item_objects(csv).length
    # require 'pry'; binding.pry
    assert_equal "Free standing Woden letters", @item_repository.item_objects(csv)[3].name
  end
end