require './test/test_helper'
require './lib/item'

class TestItem < Minitest::Test
  def test_it_initializes_with_attributes
    key_pad = {
      :id => '12345',
      :name => "Key Pad",
      :description => "Numberpad used for a lock",
      :unit_price => '5',
      :merchant_id => '54321',
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
    }
    item = Item.new(key_pad, 'parent')

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
    shoe = {
      :id => '23456',
      :name => 'Nike Super Fast',
      :description => 'Really fast shoes',
      :unit_price => '10000',
      :merchant_id => '65432',
      :created_at => '2016-01-11 09:34:06 UTC',
      :updated_at => '2007-06-04 21:35:10 UTC'
    }
    item = Item.new(shoe, 'parent')

    assert_instance_of Item, item
    assert_equal '23456', item.id
    assert_equal "Nike Super Fast", item.name
    assert_equal "Really fast shoes", item.description
    assert_equal 1e4, item.unit_price
    assert_equal '65432', item.merchant_id
    assert_equal '2016-01-11 09:34:06 UTC', item.created_at
    assert_equal '2007-06-04 21:35:10 UTC', item.updated_at
  end

  def test_unit_price_to_dollars
    key_pad = {
      :id => '12345',
      :name => "Key Pad",
      :description => "Numberpad used for a lock",
      :unit_price => '5',
      :merchant_id => '54321',
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
    }
    item_key_pad = Item.new(key_pad, 'parent')
    shoe = {
      :id => '23456',
      :name => 'Nike Super Fast',
      :description => 'Really fast shoes',
      :unit_price => '10000',
      :merchant_id => '65432',
      :created_at => '2016-01-11 09:34:06 UTC',
      :updated_at => '2007-06-04 21:35:10 UTC'
    }
    item_shoe = Item.new(shoe, 'parent')

    assert_equal 100.00, item_shoe.unit_price_to_dollars
    assert_equal 0.05, item_key_pad.unit_price_to_dollars
  end
end
