require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_reader :item
  def set_up
    item_info = {:id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"}
    @item = Item.new(item_info, [])
  end

  def test_item_exists
    set_up

    assert_instance_of Item, item
  end

  def test_created_at_instance_of_time
    set_up

    assert_instance_of Time, item.created_at
  end

  def test_updated_at_instance_of_time
    set_up

    assert_instance_of Time, item.updated_at
  end

  def test_unit_price_instance_of_bigdecimal
    set_up

    assert_instance_of BigDecimal, item.unit_price
  end

  def test_unit_to_dollar
    set_up

    assert_equal 12.0, item.unit_to_dollar
  end

  def test_id
    set_up

    assert_equal 263395237, item.id
  end

  def test_name
    set_up

    assert_equal "510+ RealPush Icon Set", item.name
  end

  def test_description
    set_up

    assert_equal "hi", item.description
  end

  def test_merchant_id
    set_up

    assert_equal 123, item.merchant_id
  end
end
