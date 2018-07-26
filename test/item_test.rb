require_relative 'test_helper'
require 'bigdecimal'
require_relative '../lib/item.rb'

class ItemTest < Minitest::Test
  def test_it_exists
    item = Item.new({
        :id          => 263395237,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(10.99,4),
        :merchant_id => 12334141,
        :created_at  => Time.now,
        :updated_at  => Time.now
      })
    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new({
        :id          => 263395237,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(10.99,4),
        :merchant_id => 12334141,
        :created_at  => Time.now,
        :updated_at  => Time.now
      })
    assert_equal 263395237, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 12334141, item.merchant_id
    assert_instance_of BigDecimal, item.unit_price
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_it_returns_price_as_dollar_float
    item = Item.new({
          :id          => 263395237,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :merchant_id => 12334141,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })
    assert_equal 10.99, item.unit_price_to_dollars
  end
end
