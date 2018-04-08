# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require 'mocha/mini_test'
require 'time'
require './lib/item.rb'
require './lib/item_repository.rb'
require './lib/file_loader.rb'
require 'pry'

# Tests item class and functionality of methods.
class ItemTest < Minitest::Test
  attr_reader :item,
              :parent

  def setup
    @item = Item.new(
      { id: '263395721',
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
        updated_at: '2008-04-02 13:48:57 UTC' }, @parent
    )
  end

  def test_item_exists
    assert_instance_of Item, item
  end

  def test_it_intializes_with_item_spec_hash
    assert_instance_of Hash, item.item_specs
  end

  def test_it_initializes_with_parent
    @parent = mock('ItemRepository')
    @parent.expects(:class).returns(ItemRepository)
    assert_equal ItemRepository, parent.class
  end

  def test_it_returns_items_id
    assert_equal 263_395_721, item.id
  end

  def test_it_returns_items_name
    assert_equal 'Disney scrabble frames', item.name
  end

  def test_it_returns_items_description_with_length
    assert_instance_of String, item.description
    assert_equal 191, item.description.length
  end

  def test_it_returns_items_merchant_id
    assert_equal 12_334_185, item.merchant_id
  end

  def test_it_returns_items_unit_price
    assert_equal 13.50, item.unit_price
    assert_equal BigDecimal, item.unit_price.class
  end

  def test_it_returns_items_creation_time
    expected = Time.parse('2016-01-11 11:51:37 UTC')
    assert_equal expected, item.created_at
  end

  def test_it_returns_items_updated_time
    expected = Time.parse('2008-04-02 13:48:57 UTC')
    assert_equal expected, item.updated_at
  end

  def test_unit_price_returns_in_dollars
    assert_instance_of Float, item.unit_price_to_dollars
  end

  def test_it_finds_merchant_by_merchant_id
    skip
    @parent = mock('ItemRepository')
    @parent.expects(:merchant_name).returns('Shopin1901')
    @parent.expects(:merchant_id).returns(12334185)
    allow(@parent).to recieve(:find_merchant_by_merchant_id).with(merchant_id)

    assert_equal 'Shopin1901', @parent.merchant_name
    assert_equal 12334185, @parent.merchant_id
    assert_equal 'Shopin1901', item.merchant
  end
end
