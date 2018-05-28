# frozen_string_literal: true

require_relative 'test_helper'
require './lib/item'

# This is an ItemTest Class
class ItemTest < Minitest::Test
  def setup
    @data = { id: 1,
              name: 'Pencil',
              description: 'You can use it to write things',
              unit_price: 1200,
              merchant_id: 2,
              created_at: '2016-01-11 11:51:37 UTC',
              updated_at: '2016-01-11 11:51:37 UTC' }
  end

  def test_it_exists
    item = Item.new(@data)

    assert_instance_of Item, item
  end

  def test_it_has_an_id
    item = Item.new(@data)

    assert_equal 1, item.id
  end

  def test_it_has_a_name
    item = Item.new(@data)

    assert_equal 'Pencil', item.name
  end

  def test_has_a_description
    item = Item.new(@data)

    assert_equal 'You can use it to write things', item.description
  end

  def test_it_has_a_unit_price
    item = Item.new(@data)

    assert_equal 12.00, item.unit_price
  end

  def test_it_has_a_merchant_id
    item = Item.new(@data)

    assert_equal 2, item.merchant_id
  end

  def test_it_has_created_at
    skip
    item = Item.new(@data)

    # assert_equal 2016-01-11 11:51:37 UTC, item.created_at
  end

  def test_it_has_updated_at
    skip
    item = Item.new(@data)

    # assert_equal 2016-01-11 11:51:37 UTC, item.updated_at
  end

  def test_unit_price_to_dollars
    item = Item.new(@data)

    assert_equal 12, item.unit_price
  end
end
