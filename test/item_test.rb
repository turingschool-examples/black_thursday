require_relative 'test_helper'

require 'bigdecimal'
require_relative '../lib/item.rb'

class ItemTest < Minitest::Test
  def test_does_create_item
    item = Item.new(
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: BigDecimal.new(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    )

    assert_instance_of Item, item
  end

  def test_does_store_item_info
    item = Item.new(
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: BigDecimal.new(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    )

    assert_equal 0, item.id
    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal 0.1099e2, item.unit_price
    assert_equal Time.now, item.created_at
    assert_equal Time.now, item.updated_at
  end
end
