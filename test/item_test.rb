require_relative 'test_helper'
require_relative '../lib/set_up'

class ItemTest < Minitest::Test
  def set_up
    item_info = {:id => "263395237", :name => "510+ RealPush Icon Set", :description => "hi",:merchant_id => "123", :unit_price => "1200", :created_at => "2016-01-11 09:34:06 UTC", :updated_at => "2007-06-04 21:35:10 UTC"}
    Item.new(item_info, [])
  end

  def test_item_exists
    assert_instance_of Item, setup
  end

  def test_created_at_instance_of_time
    assert_instance_of Time, set_up.created_at
  end

  def test_updated_at_instance_of_time
    assert_instance_of Time, set_up.updated_at
  end

  def test_unit_price_instance_of_bigdecimal
    assert_instance_of BigDecimal, set_up.unit_price
  end

  def test_unit_to_dollar
    assert_equal 12.0, set_up.unit_to_dollar
  end

  def test_id
    assert_equal 263395237, set_up.id
  end

  def test_name
    assert_equal "510+ RealPush Icon Set", set_up.name
  end

  def test_description
    assert_equal "hi", set_up.description
  end

  def test_merchant_id
    assert_equal 123, set_up.merchant_id
  end
end
