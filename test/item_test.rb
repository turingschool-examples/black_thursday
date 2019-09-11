require './test/test_helper'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({
      :id          => 0,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => Time.new(2002, 10, 31),
      :updated_at  => Time.new(2002, 10, 31)
    })
  end

  def test_item_exists
    assert_instance_of Item, @item
  end

  def test_item_has_attributes
    assert_equal 0, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_equal BigDecimal.new(10.99, 4), @item.unit_price
    assert_equal Time.new(2002, 10, 31), @item.created_at
    assert_equal Time.new(2002, 10, 31), @item.updated_at
  end

  def test_item_unit_price_can_be_converted_into_dollars
    assert_equal BigDecimal.new(10.99, 4), @item.unit_price

    assert_equal 10.99, @item.unit_price_to_dollars
  end
end
