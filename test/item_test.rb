require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test
  def test_it_exists
    i = Item.new({})
    assert_instance_of Item, i
  end

  def test_it_has_an_id
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})
    assert_equal 1, i.id
  end

  def test_it_has_an_name
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})
    assert_equal "Pencil", i.name
  end

  def test_it_has_a_description
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})
    assert_equal "You can use it to write things", i.description
  end

  def test_it_has_a_unit_price
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})

    assert_equal BigDecimal.new(10.99,4), i.unit_price
  end

  def test_created_at
    now = Time.now
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => now,
  :updated_at  => Time.now,
  :merchant_id => 2
})
    assert_equal now, i.created_at
  end

  def test_updated_at
    now = Time.now
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => now,
  :merchant_id => 2
})
    assert_equal now, i.updated_at
  end

  def test_it_has_a_merchant_id
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})

    assert_equal 2, i.merchant_id
  end

  def test_unit_price_to_dollars
    i = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
})

    assert_equal 10.99, i.unit_price_to_dollars
  end
end
