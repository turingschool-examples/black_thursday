# frozen_string_literal: true

require './test/test_helper'
require 'bigdecimal'
require_relative '../lib/item'

# :nodoc:
class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new(
      name: 'Pencil',
      description: 'Can be used to write things',
      unit_price: '1099',
      created_at: '2016-01-11 17:42:32 UTC',
      updated_at: '2016-01-11 17:42:32 UTC',
      merchant_id: '7'
    )
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_it_has_attributes
    assert_equal 'Pencil', item.name
    assert_equal 'Can be used to write things', item.description
    assert_equal 10.99, item.unit_price
  end

  def test_it_can_show_times_when_created_and_updated
    created = '2016-01-11 17:42:32 UTC'
    updated = '2016-01-11 17:42:32 UTC'
    assert_equal created, item.created_at
    assert_equal updated, item.updated_at
  end

  def test_its_price_in_dollar_amount_is_formatted_as_a_float
    assert_instance_of Float, item.price_to_dollars
  end
end
