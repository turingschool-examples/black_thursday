require './test/test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new(
      name: 'Pencil',
      description: 'Can be used to write things',
      unit_price: BigDecimal.new(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
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
    assert_equal Time.now, item.created_at
    assert_equal Time.now, item.updated_at
  end
end
