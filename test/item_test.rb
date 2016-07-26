require './test/test_helper'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test
  def test_we_can_instantiate_item_with_name
    i = Item.new({:name => "Pencil"})
    assert_equal "Pencil", i.name
  end

  def test_we_can_instantiate_item_with_different_name
    i = Item.new({:name => "Pen"})
    assert_equal "Pen", i.name
  end

  def test_can_instantiate_two_attributes
    i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
    })
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
  end

  def test_can_instantiate_time_attribute
    i = Item.new({
      :created_at  => Time.now
    })
    assert_equal Time, i.created_at.class
  end

  def test_can_instantiate_big_decimal
    i = Item.new({
      :unit_price  => BigDecimal.new(10.99,4)
    })
    assert_equal BigDecimal, i.unit_price.class
  end

  def test_can_instantiate_all_required_attributes
    i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal BigDecimal, i.unit_price.class
    assert_equal Time, i.created_at.class
    assert_equal Time, i.updated_at.class
  end

  def test_can_instantiate_without_any_attributes
    i = Item.new
    assert_equal nil, i.name
    assert_equal nil, i.description
    assert_equal nil, i.unit_price
    assert_equal nil, i.created_at
    assert_equal nil, i.updated_at
  end
end
