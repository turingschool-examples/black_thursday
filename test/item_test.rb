require './test/test_helper'
require_relative '../lib/item'
require 'bigdecimal'
require 'time'
require 'pry'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({:id => 1,
                  :name => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price => BigDecimal.new(10.99,4),
                  :created_at => Time.now,
                  :updated_at => Time.now,
                  :merchant_id => 2})
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_attributes
    assert_equal 1, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_instance_of BigDecimal, @item.unit_price
    assert_equal Time, @item.created_at.class
    assert_equal Time, @item.updated_at.class
    assert_equal 2, @item.merchant_id
  end

  def test_unit_price_to_dollars
    assert_equal Float, @item.unit_price_to_dollars.class
  end

  def test_update_attributes
    @item.update_attributes({:name => "Write Thing"})
    assert_equal "Write Thing", @item.name
    assert_equal 1, @item.id
  end
end
