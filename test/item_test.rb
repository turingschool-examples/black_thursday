require_relative 'test_helper'
require 'bigdecimal'
require './lib/item'

class MockItemRepo
end

class ItemTest < Minitest::Test
  ITEM_DATA = {
    :id          => "263538760",
    :name        => "Pencil",
    :description => "You can use it to write things",
    :merchant_id => "12334185",
    :unit_price  => "1200",
    :created_at  => "2016-01-11 09:34:06 UTC",
    :updated_at  => "2007-06-04 21:35:10 UTC"
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
    assert_instance_of BigDecimal, item.unit_price
    assert_equal 12334185, item.merchant_id
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
    assert_equal item_repo, item.parent
  end
end
