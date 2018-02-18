require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def test_item_class_exists
    item = Item.new({:name => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,})

    assert_instance_of Item, item
  end

  def test_item_attributes
    item = Item.new({:name => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,})
    expected  = "You can use it to write things"
    # expected2 = Date.today.strftime('%Y-%m-%d %H:%M:%S')

    assert_equal "Pencil", item.name
    assert_equal expected, item.description
    assert_equal 0.1099e2, item.unit_price
    # assert_equal expected2, item.created_at
    # assert_equal expected2, item.updated_at
  end

  def test_item_can_have_different_attributes
    item = Item.new({:name => "Wine",
    :description => "It gets you drunk",
    :unit_price  => BigDecimal.new(79.59,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,})

    assert_equal "Wine", item.name
    assert_equal "It gets you drunk", item.description
    assert_equal 0.7959e2, item.unit_price
  end

  def test_unit_price_to_dollars
    item = Item.new({:name => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,})

    assert_equal 10.99, item.unit_price_to_dollars
  end
end
