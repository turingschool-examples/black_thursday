require_relative 'test_helper'
require_relative '../lib/item_repository.rb'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def setup
    item_1 = Item.new({
      id: 4,
      name: "bottle",
      description: "holds water",
      unit_price: 700,
      updated_at: "1972-07-30 18:08:53 UTC",
      created_at: "1972-07-30 18:08:53 UTC",
      merchant_id: 90
      })
    item_2 = Item.new({
      id: 5,
      name: "paper",
      description: "write on it",
      unit_price: 100,
      updated_at: "1972-07-30 18:08:53 UTC",
      created_at: "1972-07-30 18:08:53 UTC",
      merchant_id: 90
      })
    item_3 = Item.new({
      id: 6,
      name: "tv",
      description: "watch stuff",
      unit_price: 25000,
      updated_at: "1972-07-30 18:08:53 UTC",
      created_at: "1972-07-30 18:08:53 UTC",
      merchant_id: 50
      })
    item_4 = Item.new({
      id: 7,
      name: "pencil",
      description: "writes things",
      unit_price: 300,
      updated_at: "1972-07-30 18:08:53 UTC",
      created_at: "1972-07-30 18:08:53 UTC",
      merchant_id: 50
      })

    items = [item_1, item_2, item_3, item_4]
    @item_repository = ItemRepository.new(items)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_can_hold_items
    assert_instance_of Array, @item_repository.list
  end

  def test_its_holding_items
    assert_instance_of Item, @item_repository.list[0]
    assert_instance_of Item, @item_repository.list[3]
  end

  def test_it_can_return_items_using_all
    assert_instance_of Item, @item_repository.all[1]
    assert_instance_of Item, @item_repository.all[2]
  end

  def test_it_can_find_by_id
    expected = @item_repository.list[0]
    actual = @item_repository.find_by_id(4)
    assert_equal expected, actual
  end

  def test_it_can_find_by_name
    expected = @item_repository.list[0]
    actual = @item_repository.find_by_name("bottle")
    assert_equal expected, actual
  end

  def test_it_can_find_all_with_description
    expected = 2
    actual = @item_repository.find_all_with_description("write").count
    assert_equal expected, actual
    actual_2 = @item_repository.find_all_with_description("WRITE").count
    assert_equal expected, actual_2
  end

  def test_it_can_find_all_by_price
    price = BigDecimal.new(7)
    expected = 1
    actual = @item_repository.find_all_by_price(price).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_price_in_range
    expected = 3
    actual = @item_repository.find_all_by_price_in_range(1.00..10.00).count
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_merchant_id
    expected = 2
    actual = @item_repository.find_all_by_merchant_id(50).count
    assert_equal expected, actual
  end

  def test_it_create_new_item_with_attributes
    new_item_added = @item_repository.create({
      name: "pots",
      description: "shiny",
      unit_price: "1000",
      merchant_id: "5555"
      })
    expected = @item_repository.list[-1]
    actual = new_item_added.last
    assert_equal expected, actual
  end

  def test_it_can_create_new_id
    expected = "8"
    actual = @item_repository.create_id
    assert_equal expected, actual
  end

  def test_it_can_update_attributes
    @item_repository.create({
      name: "pots",
      description: "shiny",
      unit_price: "1099",
      merchant_id: "5555"
      })
    new_item = @item_repository.list.last

    assert_equal "pots", new_item.name
    assert_equal "shiny", new_item.description
    assert_equal 10.99, new_item.unit_price

    @item_repository.update(8, {
      name: "chicken",
      description: "fat",
      unit_price: 12.00
      })
    changed_item = @item_repository.list.last

    assert_equal "chicken", changed_item.name
    assert_equal "fat", changed_item.description
    assert_equal 12.0, changed_item.unit_price

    assert_equal new_item.id, changed_item.id
  end

  def test_it_can_delete_item
    assert_equal @item_repository.list[0], @item_repository.find_by_name("bottle")

    @item_repository.delete(4)
    assert_nil @item_repository.find_by_name("bottle")
  end
end
