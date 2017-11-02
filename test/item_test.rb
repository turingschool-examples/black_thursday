require_relative 'test_helper'
require_relative '../lib/item'

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

    assert_equal 0.135e2, item.unit_price
    refute_equal 1350, item.unit_price
  end

  def test_merchant_id_is_correct_integer
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_equal 12334185, item.merchant_id
  end

  def test_id_returns_correct_integer
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_equal 263395721, item.id
  end

  def test_returns_correct_name
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_equal "Disney scrabble frames", item.name
  end

  def test_unit_price_converts_to_dollars
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_equal 13.5, item.unit_price_to_dollars
  end

  def test_description_returns_correct_description
    item = Item.new({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})

    assert_equal "frames", item.description
  end

end
