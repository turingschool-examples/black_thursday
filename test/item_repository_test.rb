require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_opens_csv_into_array
    item     = ItemRepository.new("./data/items.csv")
    actual   = item.all_item_data.class
    expected = Array

    assert_equal expected, actual
  end

  def test_it_returns_item_instances
    item = ItemRepository.new("./data/items.csv")
    actual   = item.all[0].class
    expected = Item

    assert_equal expected, actual
  end

  def test_it_can_return_ids
    item = ItemRepository.new("./data/items.csv")
    actual   = item.find_by_id("263395237")
    expected = item.all[0]

    assert_equal expected, actual
  end

  def test_it_can_return_names
    item = ItemRepository.new("./data/items.csv")
    actual   = item.find_by_name("510+ RealPush Icon Set")
    expected = item.all[0]

    assert_equal expected, actual
  end

  def test_it_can_find_all_with_description
    item = ItemRepository.new("./data/items.csv")
    result = item.find_all_with_description("glitter")
    actual = result[0].description.include?("glitter")

    assert_equal true, actual
  end

  def test_it_can_find_all_by_price
    item = ItemRepository.new("./data/items.csv")
    result = item.find_all_by_price("1300")
    actual = result.count

    assert_equal 8, actual

  end

  def test_it_can_find_all_by_price_in_range
    item = ItemRepository.new("./data/items.csv")
    result = item.find_all_by_price_in_range("1300".."1450")
    actual = result.count

    assert_equal 22, actual
  end

  def test_it_can_find_all_by_merchant_id
    item = ItemRepository.new("./data/items.csv")
    result = item.find_all_by_merchant_id("12334113")
    actual = result.count

    assert_equal 1, actual
  end
end
