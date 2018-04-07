require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/item.rb'
require './lib/file_loader.rb'
require 'pry'

class ItemTest < Minitest::Test
  attr_reader :i

  def setup
    @i = Item.new({
      id: '263395721',
      name: 'Disney scrabble frames',
      description: 'Disney glitter frames

      Any colour glitter available and can do any characters you require

      Different colour scrabble tiles

      Blue
      Black
      Pink
      Wooden',
      unit_price: '1350',
      merchant_id: '12334185',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '2008-04-02 13:48:57 UTC'
      })
  end

  def test_item_exists
    assert_instance_of Item, i
  end

  def test_it_returns_items_id
    assert_equal 263395721, i.id
  end

  def test_it_returns_items_name
    assert_equal 'Disney scrabble frames', i.name
  end

  def test_it_returns_items_description_with_length
    assert_instance_of String, i.description
    assert_equal 182, i.description.length
  end

  def test_it_returns_items_unit_price
    assert_equal 13.50, i.unit_price
    assert_equal BigDecimal, i.unit_price.class
  end

  def test_it_returns_items_creation_time
    assert_equal "2016-01-11 11:51:37 UTC", i.created_at
  end

  def test_it_returns_items_updated_time
    assert_equal "2008-04-02 13:48:57 UTC", i.created_at
  end

  def test_unit_price_returns_in_dollars
    assert_instance_of Float, i.unit_price_dollars
  end
end
