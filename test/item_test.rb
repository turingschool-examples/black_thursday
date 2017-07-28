require_relative 'test_helper'
require 'bigdecimal'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({
      :id          => "263395237",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1300,
      :merchant_id => 1233418,
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "1993-09-29 11:56:40 UTC",
      })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_can_call_on_name

    assert_equal "Pencil", @item.name
  end

  def test_it_can_call_on_description

    assert_equal "You can use it to write things", @item.description
  end

  def test_unit_price_to_dollars
   assert_equal 13.00, @item.unit_price_to_dollars(1300)
  end

  def test_it_has_an_id
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description_unit_price_created_at_updated_at
   assert_equal "You can use it to write things", @item.description
   assert_instance_of BigDecimal, @item.unit_price
   assert_instance_of Time, @item.created_at
   assert_instance_of Time, @item.updated_at
  end

  def test_it_can_call_on_merchant_id

    assert_equal 1233418, @item.merchant_id
  end

  def test_item_has_a_create_date
    created_at = Time.gm(2007, 6, 04, 21, 35, 10)

    assert_equal created_at, @item.created_at
  end

  def test_item_has_an_update_date
    updated_at = Time.gm(1993, 9, 29, 11, 56, 40)

    assert_equal updated_at, @item.updated_at
  end

  def test_unit_price_to_dollars_returns_a_float
    # require "pry"; binding.pry
    assert_instance_of Float, @item.unit_price_to_dollars(1300)
    # assert_equal @item.unit_price_to_dollars.class, Float
    # assert_equal @item.unit_price_to_dollars, 13.0
  end

end
