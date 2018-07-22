require_relative './test_helper'
require './lib/item'
require 'bigdecimal'


class ItemTest < Minitest::Test

  def setup
    @info = {
      id:          1,
      name:        "Pencil",
      description: "You can use it to write things",
      unit_price:  "1099",
      created_at:  Time.now,
      updated_at:  Time.now,
      merchant_id: 2
    }

  end

  def test_it_exists
    item = Item.new(@info)

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new(@info)

    assert_equal 1, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal "1099", item.unit_price
    assert_equal Time, item.created_at.class
    assert_equal Time, item.updated_at.class
    assert_equal 2, item.merchant_id
  end

  def test_can_convert_price_to_dollars
    item = Item.new(@info)

    assert_equal 10.99, item.unit_price_to_dollars
    @info[:unit_price] = "10.99"
    assert_equal 10.99, item.unit_price_to_dollars
  end


end
