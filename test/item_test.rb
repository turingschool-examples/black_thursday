require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({:id => 5,
    :name => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :merchant_id => 6,
    :created_at  => Time.now,
    :updated_at  => Time.now,})
  end

  def test_item_class_exists
    assert_instance_of Item, @item
  end

  def test_item_attributes
    expected = "You can use it to write things"
    # expected2 = Date.today.strftime('%Y-%m-%d %H:%M:%S')

    assert_equal 5, @item.id
    assert_equal "Pencil", @item.name
    assert_equal expected, @item.description
    assert_equal 0.1099e2, @item.unit_price
    assert_equal 6, @item.merchant_id
    # assert_equal expected2, @item.created_at
    # assert_equal expected2, @item.updated_at
  end

  def test_item_can_have_different_attributes
    item = Item.new({:id => 1,
    :name => "Wine",
    :description => "It gets you drunk",
    :unit_price  => BigDecimal.new(79.59,4),
    :merchant_id => 343414,
    :created_at  => Time.now,
    :updated_at  => Time.now,})

    assert_equal 1, item.id
    assert_equal "Wine", item.name
    assert_equal "It gets you drunk", item.description
    assert_equal 343414, item.merchant_id
    assert_equal 0.7959e2, item.unit_price
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end
end
