require_relative 'test_helper'

require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_opens_csv_into_array
    item     = ItemRepository.new
    actual   = item.all_item_data.class
    expected = Array

    assert_equal expected, actual
  end

  def test_it_returns_item_instances
    item = ItemRepository.new
    actual   = item.all[0].class
    expected = Item

    assert_equal expected, actual
  end

  def test_it_can_return_ids
    item = ItemRepository.new
    actual   = item.find_by_id("263395237")
    expected = item.all[0]

    assert_equal expected, actual
  end

  def test_it_can_return_names
    item = ItemRepository.new
    actual   = item.find_by_name("510+ RealPush Icon Set")
    expected = item.all[0]

    assert_equal expected, actual
  end

  def test_it_can_find_all_with_description
    item = ItemRepository.new
    result = item.find_all_with_description("glitter")
    actual = result[0].description.include?("glitter")
    
    assert_equal true, actual
  end
end
