require_relative 'test_helper'
require './lib/item.rb'
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test
  def setup
    item = { id: 263396209,
             name: 'Vogue Paris Original Givenchy 2307',
             description: 'Vogue Paris Original 2307; ca. 1980; Givenchy Dress',
             unit_price: 2999,
             merchant_id: 12334105,
             created_at: '2016-01-11 10:37:09 UTC',
             updated_at: '1995-03-19 10:02:43 UTC' }
    @test_item = Item.new(item)
  end

  def test_item_exists
    assert_instance_of Item, @test_item
  end

  def test_it_has_attributes
    assert_equal 263396209, @test_item.id
    assert_equal 'Vogue Paris Original Givenchy 2307', @test_item.name
    assert_equal 'Vogue Paris Original 2307; ca. 1980; Givenchy Dress', @test_item.description
    assert_equal 2999, @test_item.unit_price
    assert_equal 12334105, @test_item.merchant_id
    assert_equal '2016-01-11 10:37:09 UTC', @test_item.created_at
    assert_equal '1995-03-19 10:02:43 UTC', @test_item.updated_at
  end

  def test_update_name
    assert_equal 'Vogue Paris Original Givenchy 2307', @test_item.name
    @test_item.update_name('Dress Thingy')
    assert_equal 'Dress Thingy', @test_item.name
  end

  def test_update_description
    assert_equal 'Vogue Paris Original 2307; ca. 1980; Givenchy Dress', @test_item.description
    @test_item.update_description('Red Dress Thingy, size 3')
    assert_equal 'Red Dress Thingy, size 3', @test_item.description
  end

  def test_update_unit_price
    assert_equal 2999, @test_item.unit_price
    @test_item.update_unit_price(1200)
    assert_equal 1200, @test_item.unit_price
  end
end
