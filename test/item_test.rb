require './test/test_helper'
require './lib/item'

class MerchantTest < Minitest::Test
  def test_item_class_exists
    item = Item.new({:name => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,})

    assert_instance_of Item, item
  end

  def test_item_attributes
    skip
    item = Item.new({:name => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,})
    expected = "You can use it to write things"

    assert_equal "Pencil", item.name
    assert_equal expected, item.description
    assert_equal "Pencil", item.unit_price
    assert_equal "Pencil", item.created_at
    assert_equal "Pencil", item.updated_at
  end

  def test_item_can_have_different_attributes
    skip
    item = Item.new({:name => "Wine",
    :description => "It gets you drunk",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,})

    assert_equal "Wine", item.name
    assert_equal "It gets you drunk", item.description
    assert_equal "Pencil", item.unit_price
    assert_equal "Pencil", item.created_at
    assert_equal "Pencil", item.updated_at
  end

  def test_unit_price_to_dollars
    skip
    item = Item.new({:name => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,})

    assert_equal 10.99, item.unit_price_to_dollars
  end
end
