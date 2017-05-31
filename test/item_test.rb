require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'pry'
require 'bigdecimal'

class ItemTest < MiniTest::Test

  def test_it_can_be_created
    assert_instance_of Item, Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 12345678,
  })
  end

  def test_it_can_call_on_name
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 12345678,
    })

    assert_equal "Pencil", item.name
  end

  def test_it_can_call_on_description
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 12345678,
    })

    assert_equal "You can use it to write things", item.description
  end


  def test_it_can_call_on_unit_price
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 12345678,
    })

    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_it_can_call_on_merchant_id
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    :merchant_id => 12345678,
    })

    assert_equal 12345678, item.merchant_id
  end


  def test_it_can_call_on_created_at
    time_created_at = Time.now
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => time_created_at,
    })

    assert_equal time_created_at, item.created_at
  end

  def test_it_can_call_on_updated_at
    time_updated_at = Time.now
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :updated_at  => time_updated_at,
    })

    assert_equal time_updated_at, item.updated_at
  end


end
