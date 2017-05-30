require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item.rb'
require 'pry'

class ItemTest < Minitest::Test

  def test_item_exists
    item = Item.new(nil, nil, nil, nil, nil, nil, nil)
    assert_instance_of Item, item
  end

  def test_item_has_an_id
    item = Item.new(13, nil, nil, nil, nil, nil, nil)
    assert_equal item.id, 13
  end

  def test_item_has_a_name
    item = Item.new(nil, "scarf", nil, nil, nil, nil, nil)
    assert_equal item.name, "scarf"
  end

  def test_item_has_a_description
    item = Item.new(nil, nil, "blue and fuzzy", nil, nil, nil, nil)
    assert_equal item.description, "blue and fuzzy"
  end

  def test_item_has_a_price
    item = Item.new(nil, nil, nil, 14.50, nil, nil, nil)
    assert_equal item.unit_price, 14.50
  end

  def test_item_has_a_merchant_id
    item = Item.new(nil, nil, nil, nil, 145, nil, nil)
    assert_equal item.merchant_id, 145
  end

  def test_item_has_a_create_date
    time = Time.now
    item = Item.new(nil, nil, nil, nil, nil, time, nil)
    assert_equal item.created_at, time
  end

  def test_item_has_an_update_date
    time = Time.now
    item = Item.new(nil, nil, nil, nil, nil, nil, time)
    assert_equal item.updated_at, time
  end
  
end
