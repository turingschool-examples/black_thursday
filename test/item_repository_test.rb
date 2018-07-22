require_relative 'test_helper'
require_relative '../lib/item_repository.rb'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_can_hold_items
    assert_instance_of Array, @item_repository.items
  end

  def test_it_holding_items
    assert_instance_of Item, @item_repository.items[0]
    assert_instance_of Item, @item_repository.items[25]
  end

  def test_it_can_return_items_using_all
    assert_instance_of Item, @item_repository.all[5]
    assert_instance_of Item, @item_repository.all[97]
  end

  def test_it_can_find_by_id
    expected = @item_repository.items[0]
    actual = @item_repository.find_by_id(263395237)
    assert_equal expected, actual
  end

  def test_it_can_find_by_name
    expected = @item_repository.items[0]
    actual = @item_repository.find_by_name("510+ RealPush Icon Set")
    assert_equal expected, actual
  end

  def test_it_can_find_all_with_description
    expected = 6
    actual = @item_repository.find_all_with_description("storage").count
    assert_equal expected, actual
    actual_2 = @item_repository.find_all_with_description("STORAGE").count
    assert_equal expected, actual_2
  end

  def test_it_can_find_all_by_price
    expected = 50
    actual = @item_repository.find_all_by_price(1200).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_price_in_range
    expected = 247
    actual = @item_repository.find_all_by_price_in_range(1200..2000).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_merchant_id
    expected = 6
    actual = @item_repository.find_all_by_merchant_id(12334185).count
    assert_equal expected, actual
  end

  def test_it_create_new_item_with_attributes
    new_item_added = @item_repository.create("pots", "shiny", "1000", "5555")
    expected = @item_repository.items[-1]
    actual = new_item_added.last
    assert_equal expected, actual
  end

  def test_it_can_create_new_id
    expected = "263567475"
    actual = @item_repository.create_id
    assert_equal expected, actual
  end

end
