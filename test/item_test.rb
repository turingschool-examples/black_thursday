require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  attr_reader   :item

  def setup
    @item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 100
    })
  end

  def test_it_can_create_an_item
    assert item
  end

  def test_it_can_return_id
    assert_equal 1, item.id
  end

  def test_it_can_return_name
    assert_equal "Pencil", item.name
  end

  def test_it_can_return_unit_price_as_big_decimal
    assert_equal 10.99, item.unit_price
    assert_instance_of BigDecimal, item.unit_price
  end

  def test_it_can_return_unit_price_as_big_decimal_given_fixnum
    item_2 = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => 10,
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 100
    })
    assert_equal "10.00", item_2.unit_price.to_s
    assert_instance_of BigDecimal, item.unit_price
  end

  def test_it_can_return_created_at_as_time
    skip
    ##Need to find a way to test this properly
    assert_instance_of Time, item.created_at
  end

  def test_it_can_return_updated_at_as_time
    skip
    ##Need to find a way to test this properly
    assert_instance_of Time, item.updated_at
  end

  def test_it_can_return_merchant_id
    assert_equal 100, item.merchant_id
  end

  def test_it_can_return_price_in_dollars_as_float
    skip
    ##Need to determine what we need here
    assert_instance_of Float, item.unit_price_to_dollars
  end
end