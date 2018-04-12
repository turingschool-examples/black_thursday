# frozen_string_literal: true

require 'bigdecimal'
require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @time = "2016-01-11 09:34:06 UTC"
  end

  def test_it_exists
    item = Item.new(
      name:         'Pencil',
      description:  'You can use it to write things',
      unit_price:   1099,
      merchant_id:  12334141,
      created_at:   @time,
      updated_at:   @time
    )

    assert_instance_of Item, item
  end
  def test_it_has_attributes
    item = Item.new(
      id:          44444,
      name:        'Pencil',
      description: 'You can use it to write things',
      merchant_id:  12334141,
      unit_price:  1099,
      created_at:  @time,
      updated_at:  @time
    )
    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal 10.99, item.unit_price_to_dollars
    assert_instance_of Time, item.created_at
    assert_equal 44444, item.id
    assert_equal 12334141, item.merchant_id
    assert_instance_of BigDecimal, item.unit_price
    assert_instance_of Time, item.updated_at

  end

  def test_helper_modify
    item = Item.new(name:         'Pencil',
                    description:  'You can use it to write things',
                    unit_price:   1099,
                    merchant_id:  12334141,
                    created_at:   @time,
                    updated_at:   @time)
    data = { name:        'Pencil',
             description: 'You can use it to write things',
             unit_price:   1099,
             merchant_id:  12334141,
             created_at:   @time,
             updated_at:   @time }
    actual = item.modify(data)
    assert_instance_of BigDecimal, actual[:unit_price]
    assert_instance_of Time, actual[:created_at]
    assert_instance_of Time, actual[:updated_at]
    assert_instance_of Float, actual[:unit_price_to_dollars]
  end
end
