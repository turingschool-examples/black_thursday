require_relative 'test_helper'
require_relative '../lib/item.rb'

class ItemTest <  Minitest::Test
  def test_it_exists
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })
    assert_instance_of Item, i
  end

  def test_id
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })
    actual = i.id
    expected = 1
    assert_equal expected, actual
  end

  def test_name
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })
    actual = i.name
    expected = "Pencil"
    assert_equal expected, actual
  end

  def test_description
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })
    actual = i.description
    expected = "You can use it to write things"
    assert_equal expected, actual
  end

  def test_unit_price
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })
    actual = i.unit_price
    expected = BigDecimal.new(10.99,4)
    assert_equal expected, actual
  end

  def test_created_at
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.new(2018),
      :updated_at => Time.now,
      :merchant_id => 2
      })
    actual = i.created_at
    expected = Time.new(2018)
    assert_equal expected, actual
  end

  def test_updated_at
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.new(2018),
      :merchant_id => 2
      })
    actual = i.updated_at
    expected = Time.new(2018)
    assert_equal expected, actual
  end

  def test_mercant_id
    i = Item.new({
      :id     => 1,
      :name    => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })
    actual = i.merchant_id
    expected = 2
    assert_equal expected, actual
  end
end
