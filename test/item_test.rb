require 'bigdecimal'
require 'time'
require_relative 'test_helper'
require_relative '../lib/elementals/item'

# item minitest
class ItemTest < Minitest::Test
  def setup
    @time = Time.now
    @item = Item.new(
      id:           1,
      name:         'Pencil',
      description:  'It is yellow.',
      unit_price:   1099,
      merchant_id:  12334185,
      created_at:   @time,
      updated_at:   @time
    )
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_an_id
    assert_equal 1, @item.id
  end

  def test_it_has_name
    assert_equal 'Pencil', @item.name
  end

  def test_it_has_description
    assert_equal 'It is yellow.', @item.description
  end

  def test_it_has_unit_price
    assert_equal 10.99, @item.unit_price
  end

  def test_it_has_merchant_id
    assert_equal 12334185, @item.merchant_id
  end

  def test_it_has_created_at
    assert_equal @time, @item.created_at
  end

  def test_it_has_updated_at
    assert_equal @time, @item.updated_at
  end

  def test_it_can_set_unit_price_to_dollars
    assert_instance_of BigDecimal, @item.unit_price
    assert_equal 10.99, @item.unit_price
    assert_instance_of Float, @item.unit_price_to_dollars
  end
end
