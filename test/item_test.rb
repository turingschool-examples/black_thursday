require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test
  def test_it_exits
    item = Item.new(name: 'Pencil',
                    description: 'You can use it to write things',
                    unit_price: BigDecimal.new(10.99, 4),
                    created_at: Time.now,
                    updated_at: Time.now)

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new(name: 'Pencil',
                    description: 'You can use it to write things',
                    unit_price: BigDecimal.new(10.99, 4),
                    created_at: Time.now,
                    updated_at: Time.now)

    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal BigDecimal.new(10.99, 4), item.unit_price
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end
end
