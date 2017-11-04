require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def setup
    item_info = ({:id => "263395721", :name => "Disney scrabble frames", :description => "frames", :unit_price => "1350", :merchant_id => "12334185", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2008-04-02 13:48:57 UTC"})
    item = Item.new(item_info, [])
  end

  def test_it_exists
    assert_instance_of Item, setup
  end

  def test_time_returns_time_exists
    assert_instance_of Time, setup.created_at
    assert_instance_of Time, setup.updated_at
  end

  def test_unit_price_converts_to_bigdecimal
    assert_instance_of BigDecimal, setup.unit_price
  end

  def test_it_pulls_unit_price_in_format
    assert_equal 0.135e2, setup.unit_price
    refute_equal 1350, setup.unit_price
  end

  def test_merchant_id_is_correct_integer
    assert_equal 12334185, setup.merchant_id
  end

  def test_id_returns_correct_integer
    assert_equal 263395721, setup.id
  end

  def test_returns_correct_name
    assert_equal "Disney scrabble frames", setup.name
  end

  def test_unit_price_converts_to_dollars
    assert_equal 13.5, setup.unit_price_to_dollars
  end

  def test_description_returns_correct_description
    assert_equal "frames", setup.description
  end

end
