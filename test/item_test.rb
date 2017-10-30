require_relative 'test_helper'
require_relative '../lib/item'
require 'minitest/autorun'
require 'minitest/pride'


class ItemTest < Minitest::Test
  def test_it_exists
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_instance_of Item, item
  end

  def test_time_returns_time_exists
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_unit_price_converts_to_bigdecimal
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_instance_of BigDecimal, item.unit_price
  end

  def test_it_pulls_unit_price_in_format
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_equal 0.135e4, item.unit_price
    refute 1350, item.unit_price
  end

end
