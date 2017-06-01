require_relative 'test_helper'

require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_opens_csv_into_array
    item     = ItemRepository.new
    actual   = item.all_item_data.class
    expected = Array

    assert_equal expected, actual
  end
  #
  # def test_it_returns_item_instances
  #   skip #No visible difference...wtf?
  #   item = itemRepository.new
  #   actual   = item.all[0]
  #   expected = "#<item:0xXXXXXX @id=\"12334105\", @name=\"Shopin1901\">"
  #
  #   assert_equal expected, actual
  # end
  #
  # def test_it_can_return_ids
  #   item = itemRepository.new
  #   actual   = item.find_by_id("12334105")
  #   expected = item.all[0]
  #
  #   assert_equal expected, actual
  # end
  #
  # def test_it_can_return_names
  #   item = itemRepository.new
  #   actual   = item.find_by_name("Shopin1901")
  #   expected = item.all[0]
  #
  #   assert_equal expected, actual
  # end
  #
  # def test_it_can_find_all_by_name
  #   item = itemRepository.new
  #   actual   = item.find_all_by_name("shopin")
  #   expected = [item.all[0]]
  #
  #   assert_equal expected, actual
  # end

end
