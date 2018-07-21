require_relative "../test/test_helper"
require_relative "../lib/item"
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :unit_price  => BigDecimal.new(10.99,4),
            :created_at  => Time.now,
            :updated_at  => Time.now,
            :merchant_id => 2
            })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_attributes
  assert_equal 1, @item.id
  assert_equal "Pencil", @item.name
  assert_equal "You can use it to write things", @item.description
  assert_instance_of BigDecimal, @item.unit_price
  assert_instance_of Time, @item.created_at
  assert_instance_of Time, @item.updated_at
  assert_equal 2, @item.merchant_id
  end

end
