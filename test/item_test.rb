require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_exists
    item = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :created_at  => Time.now,
          :updated_at  => Time.now,
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
          :created_at  => "2018-10-22 15:54:17 -0600",
          :updated_at  => "2018-10-22 16:54:17 -0600",
          :merchant_id => 2
        })
    assert_equal 1, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal BigDecimal.new(10.99,4), item.unit_price
    assert_equal "2018-10-22 15:54:17 -0600", item.created_at
    assert_equal "2018-10-22 16:54:17 -0600", item.updated_at
    assert_equal 2, item.merchant_id
  end
end
