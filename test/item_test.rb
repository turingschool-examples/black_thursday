require './test/test_helper'
require './lib/item'

class TestItem < Minitest::Test
  attr_reader :item, :item_2

  def setup
    parent = mock('parent')
    key_pad = {
      :id => '12345',
      :name => "Key Pad",
      :description => "Numberpad used for a lock",
      :unit_price => '5',
      :merchant_id => '54321',
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
    }
    @item = Item.new(key_pad, parent)
    # require "pry"; binding.pry
    shoe = {
      :id => '23456',
      :name => 'Nike Super Fast',
      :description => 'Really fast shoes',
      :unit_price => '10000',
      :merchant_id => '65432',
      :created_at => '2016-01-11 09:34:06 UTC',
      :updated_at => '2007-06-04 21:35:10 UTC'
    }
    @item_2 = Item.new(shoe, parent)
  end

  def test_it_initializes_with_attributes
    assert_instance_of Item, item
    assert_equal '12345', item.id
    assert_equal "Key Pad", item.name
    assert_equal "Numberpad used for a lock", item.description
    assert_equal 0.5e1, item.unit_price
    assert_equal '54321', item.merchant_id
    assert_equal Time.now.to_s, item.created_at
    assert_equal Time.now.to_s, item.updated_at
  end

  def test_it_initializes_with_other_attributes
    assert_instance_of Item, item_2
    assert_equal '23456', item_2.id
    assert_equal "Nike Super Fast", item_2.name
    assert_equal "Really fast shoes", item_2.description
    assert_equal 1e4, item_2.unit_price
    assert_equal '65432', item_2.merchant_id
    assert_equal '2016-01-11 09:34:06 UTC', item_2.created_at
    assert_equal '2007-06-04 21:35:10 UTC', item_2.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 0.05, item.unit_price_to_dollars
    assert_equal 100.00, item_2.unit_price_to_dollars
  end

  def test_can_use_merchant
    item.parent.stubs(:find_merchant_by_id).with("54321").returns(true)

    assert item.merchant
  end
end
