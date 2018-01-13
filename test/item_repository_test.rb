require_relative 'test_helper'
require_relative "../lib/item_repository"


class ItemRepositoryTest < Minitest::Test

  attr_reader :path,
              :item

  def setup
    @path = ("./test/fixtures/items_sample.csv")
    @item = ItemRepository.new(path, mock('SalesEngine'))
  end

  def test_all_items_is_returned
    assert_instance_of ItemRepository, item
    assert_equal 25, item.items.count
  end

  def test_grabs_item_by_name
    item_name_1 = mock('toy')
    item_name_2 = mock('toy')
    item_name_3 = mock('toy')
    item.stubs(:find_by_name).returns([item_name_1, item_name_2, item_name_3])

    assert_equal 3, item.find_by_name.count
    assert_equal [item_name_1, item_name_2, item_name_3], item.find_by_name
  end



end
