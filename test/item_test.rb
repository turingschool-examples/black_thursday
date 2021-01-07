require_relative './test_helper'
require './lib/item'
require 'time'
require 'bigdecimal'


class ItemTest < Minitest::Test
  def test_it_exists_and_has_attributes
    item = Item.new({
                :id          => 1,
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => BigDecimal.new(10.99,4),
                :created_at  => Time.now,
                :updated_at  => Time.now,
                :merchant_id => 2
                }, 0)
    assert_instance_of Item, item
    assert_equal 1, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal BigDecimal.new(10.99, 4), item.unit_price
    # assert_equal "", item.created_at
    # assert_equal "", item.updated_at
    assert_equal 2, item.merchant_id
  end
  
end
