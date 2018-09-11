require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @time_1 = '1993-10-28 11:56:40 UTC'

    @time_2 = '1993-09-29 12:45:30 UTC'

    @attributes = {id:       123,
                name:        'testname',
                description: 'fakedescription',
                merchant_id: 456,
                unit_price:  BigDecimal.new(12.00, 4),
                created_at:  Time.parse(@time_1),
                updated_at:  Time.parse(@time_2)}

    @item = Item.new(@attributes)

  end

  def test_it_exists
    assert_instance_of(Item, @item)
  end

  def test_it_can_show_attributes
    assert_equal(123, @item.id)
    assert_equal('testname', @item.name)
    assert_equal('fakedescription', @item.description)
    assert_equal(456, @item.merchant_id)
    assert_equal(BigDecimal.new(12.00, 4), @item.unit_price)
    assert_equal(Time.parse(@time_1), @item.created_at)
    assert_equal(Time.parse(@time_2), @item.updated_at)
  end

  def test_it_can_return_unit_price_in_dollars
    assert_equal 12.00, @item.unit_price_to_dollars
  end
end
