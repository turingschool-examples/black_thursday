require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/items'
require 'bigdecimal'
require 'time'

class ItemsTest < Minitest::Test
  def test_items_exists
    i = Items.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    assert_instance_of Items, i
  end

  def test_check_that_items_has_attributes
    i = Items.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
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
    i = Items.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99111,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    assert_equal 10.99, i.unit_price_to_dollars
  end
end
