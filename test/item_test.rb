require_relative './helper'
require_relative '../lib/item'
class ItemTest < Minitest::Test
  def setup
    @time_now = Time.parse('2016-01-11 09:34:06 UTC')
    @update_time = Time.parse('2007-06-04 21:35:10 UTC')
    @i = Item.new({
                    :id          => 1,
                    :name        => 'Pencil',
                    :description => 'You can use it to write things',
                    :unit_price  => BigDecimal.new(10.99, 4),
                    :created_at  => '2016-01-11 09:34:06 UTC',
                    :updated_at  => '2007-06-04 21:35:10 UTC',
                    :merchant_id => 2
                  })
  end

  def test_item_exists
    assert_instance_of Item, @i
  end

  def test_item_has_id
    assert_equal 1, @i.id
  end

  def test_item_has_name
    assert_equal 'Pencil', @i.name
  end

  def test_it_has_description
    assert_equal 'You can use it to write things', @i.description
  end

  def test_it_has_a_unit_price
    assert_equal 10.99, @i.unit_price
  end

  def test_it_can_be_created_at_a_certain_time
    assert_equal @time_now, @i.created_at
  end

  def test_it_can_be_updated_at_a_certain_time
    assert_equal @update_time, @i.updated_at
  end

  def test_it_has_merchant_id
    assert_equal 2, @i.merchant_id
  end

  def test_it_can_convert_to_dollars
    assert_equal 10.99, @i.unit_price_to_dollars
  end
end
