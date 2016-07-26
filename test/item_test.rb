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

  def test_can_instantiate_time_object
    time = Time.parse("2016-01-11 09:34:06 UTC")
    i = Item.new({
      :created_at  => time
    })
    assert_equal Time, i.created_at.class
  end

  def test_can_instantiate_big_decimal_objects
    unit_price = BigDecimal.new(10.99,4)
    i = Item.new({
      :unit_price  => unit_price
    })
    assert_equal BigDecimal, i.unit_price.class
  end

  def test_can_instantiate_all_required_attributes
    data = {
      :id          => 263515792,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.parse("2016-01-11 09:34:06 UTC"),
      :updated_at  => Time.parse("2016-01-11 09:34:06 UTC")
    }
    i = Item.new(data)
    assert_equal data[:id], i.id
    assert_equal data[:name], i.name
    assert_equal data[:description], i.description
    assert_equal data[:unit_price], i.unit_price
    assert_equal data[:created_at], i.created_at
    assert_equal data[:updated_at], i.updated_at
  end
end
