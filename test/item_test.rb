require './test/test_helper'
require_relative '../lib/item'
require 'pry'
require 'bigdecimal'

class ItemTest < MiniTest::Test

  def setup
    item_created_at = '2017-05-27 15:44:02 UTC'
    item_updated_at = '2017-05-29 14:56:56 UTC'
    @item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => "1099",
    :created_at  => item_created_at,
    :updated_at  => item_updated_at,
    :merchant_id => 12345678,
    }, ir = nil)
  end

  def test_it_can_call_on_name

    assert_equal "Pencil", @item.name
  end

  def test_it_can_call_on_description

    assert_equal "You can use it to write things", @item.description
  end


  def test_it_can_call_on_unit_price

    assert_equal BigDecimal.new(10.99,4), @item.unit_price
  end

  def test_it_can_call_on_merchant_id

    assert_equal 12345678, @item.merchant_id
  end

  def test_item_has_a_create_date
    created_at = Time.gm(2017, 5, 27, 15, 44, 2)

    assert_equal created_at, @item.created_at
  end

  def test_item_has_an_update_date
    updated_at = Time.gm(2017, 5, 29, 14, 56, 56)

    assert_equal updated_at, @item.updated_at
  end
end
