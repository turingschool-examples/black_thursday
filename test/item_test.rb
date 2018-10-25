require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test
  def test_items_exists
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    })
    assert_instance_of Item, i
  end

  def test_check_that_items_has_attributes
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(1099.00,4),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    })
  assert_equal 1, i.id
  assert_equal "Pencil", i.name
  assert_equal "You can use it to write things", i.description
  assert_equal BigDecimal.new(10.99,4), i.unit_price
  assert_instance_of Time, i.created_at
  assert_instance_of Time, i.updated_at
  assert_equal 2, i.merchant_id
  end

  def test_unit_price_to_dollars_returns_float
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(1099.111,4),
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => 2
    })
    assert_equal 10.99, i.unit_price_to_dollars
  end
end
