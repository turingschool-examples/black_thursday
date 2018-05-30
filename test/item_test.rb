require './test_helper'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test
  def test_item_has_attributes
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => Time.now,
      :updated_at  => Time.now
      }
    item = Item.new(attributes)
    current_time = Time.now.strftime("%Y-%m-%d %H:%M:%S %z")


    assert_equal 0, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_instance_of BigDecimal, item.unit_price
    # assert_equal current_time, item.created_at
    # assert_equal current_time, item.updated_at
    assert_equal 0, item.merchant_id
  end

  def test_unit_price_to_dollars
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :created_at  => Time.now,
      :updated_at  => Time.now
      }
    item = Item.new(attributes)

    assert_equal 10.99, item.unit_price_to_dollars
    assert_instance_of Float, item.unit_price_to_dollars
  end
end
# 2016-01-11 09:34:06 UTC created_at
