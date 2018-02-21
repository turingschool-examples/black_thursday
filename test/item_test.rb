# frozen_string_literal: true

require_relative 'test_helper'

require 'bigdecimal'
require_relative '../lib/item.rb'
require_relative 'mocks/test_engine'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new(
      {
        id: '23',
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '1099',
        created_at: '2016-01-11 17:42:32 UTC',
        updated_at: '2016-01-11 17:42:32 UTC',
        merchant_id: '7'
      },
      MOCK_ITEM_REPOSITORY
    )
  end

  def test_does_create_item
    assert_instance_of Item, @item
    assert_instance_of ItemRepository, @item.item_repository
  end

  def test_does_store_item_info
    assert_equal 23, @item.id
    assert_equal 'Pencil', @item.name
    assert_equal 'You can use it to write things', @item.description
    assert_equal BigDecimal.new(1099 / 100.0, 4), @item.unit_price
    assert_equal Time.parse('2016-01-11 17:42:32 UTC'), @item.created_at
    assert_equal Time.parse('2016-01-11 17:42:32 UTC'), @item.updated_at
    assert_equal 7, @item.merchant_id
  end
end
