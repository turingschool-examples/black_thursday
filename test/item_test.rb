# frozen_string_literal: false

require_relative 'test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @args = { id:          '1234',
              name:        'Pencil',
              description: 'You can use it to write things',
              unit_price:  '1099',
              created_at:  '2016-01-11 09:34:06 UTC',
              updated_at:  '2007-06-04 21:35:10 UTC' }
    @item = Item.new(@args)
  end

  def test_it_exits
    assert_instance_of Item, @item
  end

  def test_it_has_attributes
    assert_equal 1234, @item.id
    assert_equal 'Pencil', @item.name
    assert_equal 'You can use it to write things', @item.description
    assert_equal 10.99, @item.unit_price
    assert_instance_of BigDecimal, @item.unit_price
  end

  def test_time_attributes_for_created
    assert_instance_of Time, @item.created_at
    assert_equal 2_016, @item.created_at.year
    assert_equal 34, @item.created_at.min
  end

  def test_time_attributes_for_updated
    assert_instance_of Time, @item.updated_at
    assert_equal 6, @item.updated_at.mon
    assert_equal 21, @item.updated_at.hour
  end

  def test_unit_price_to_dollars
    assert_instance_of Float, @item.unit_price_to_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end
end
