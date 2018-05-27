require_relative 'test_helper'
require 'bigdecimal'
require './lib/item'

class MockItemRepo
end

class ItemTest < Minitest::Test
  PRICE = BigDecimal.new(10.99,4)
  TIME_1 = Time.now
  TIME_2 = Time.now
  ITEM_DATA = {
    :id          => "263538760",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :merchant_id => "12334185",
    :unit_price  => PRICE,
    :created_at  => TIME_1,
    :updated_at  => TIME_2
    }

  def test_it_exists
    item_repo = MockItemRepo.new
    item = Item.new(ITEM_DATA, item_repo)

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item_repo = MockItemRepo.new
    item = Item.new(ITEM_DATA, item_repo)

    assert_equal 263538760, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal PRICE, item.unit_price
    assert_equal 12334185, item.merchant_id
    assert_equal TIME_1, item.created_at
    assert_equal TIME_2, item.updated_at
    assert_equal item_repo, item.parent
  end
end
