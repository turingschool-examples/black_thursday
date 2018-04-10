require './test/test_helper'
require 'bigdecimal'
SimpleCov.start
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
      name:        'Pencil',
      description: 'You can use it to write things',
      unit_price:  1099,
      created_at:  @time,
      updated_at:  @time
    )
    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal 10.99, item.unit_price_to_dollars
    assert_instance_of Time, item.created_at
  end
end
