require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_exists
    item = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :created_at  => "2016-01-11 11:46:07 UTC",
          :updated_at  => "2016-01-11 11:46:07 UTC",
          :merchant_id => 2
        })
    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :created_at  => "2016-01-11 11:46:07 UTC",
          :updated_at  => "2016-01-11 11:49:05 UTC",
          :merchant_id => 2
        })
    assert_equal 1, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal BigDecimal.new(10.99,4), item.unit_price
    assert_equal Time.utc(2016, 01, 11, 11, 46, 07), item.created_at
    assert_equal Time.utc(2016, 01, 11, 11, 49, 05), item.updated_at
    assert_equal 2, item.merchant_id
  end

  def test_it_can_return_unit_price_to_dollars
    item = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.993,4),
          :created_at  => "2016-01-11 11:46:07 UTC",
          :updated_at  => "2016-01-11 11:46:07 UTC",
          :merchant_id => 2
        })
    assert_equal 0.11, item.unit_price_to_dollars
    assert_instance_of Float, item.unit_price_to_dollars
  end

end
