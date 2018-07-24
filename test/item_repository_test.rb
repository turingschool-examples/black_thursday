require_relative 'test_helper'
require_relative '../lib/item_repository.rb'
require 'pry'

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
    price = BigDecimal.new(25)
    expected = 79
    actual = @item_repository.find_all_by_price(price).count
    # binding.pry
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_price_in_range
    expected = 205
    actual = @item_repository.find_all_by_price_in_range(10.00..15.00).count
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

  def test_it_can_update_attributes
    @item_repository.create("pots", "shiny", 1099, "5555")
    new_item = @item_repository.items.last

    last_item_name = new_item.name
    last_item_description = new_item.description
    last_item_price = new_item.unit_price
    # binding.pry
    assert_equal "pots", last_item_name
    assert_equal "shiny", last_item_description
    assert_equal 10.99, last_item_price

    @item_repository.update(263567475, "chicken", "fat", "12")
    changed_item = @item_repository.items.last

    assert_equal "chicken", changed_item.name
    assert_equal "fat", changed_item.description
    assert_equal "12", changed_item.unit_price

    assert_equal new_item.id, changed_item.id
  end

  def test_it_can_delete_item
    assert_equal @item_repository.items[0], @item_repository.find_by_name("510+ RealPush Icon Set")

    @item_repository.delete(263395237)
    assert_nil @item_repository.find_by_name("510+ RealPush Icon Set")
  end
end
