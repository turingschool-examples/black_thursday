require './test/test_helper.rb'
require './lib/item.rb'

class ItemTest < Minitest::Test
  def setup
    @i = Item.new(
      id: '123456',
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: BigDecimal(10.99, 4),
      created_at: '2016-01-11 11:51:36 UTC',
      updated_at: '2001-09-17 15:28:43 UTC'
    )
  end

  def test_it_exists
    assert_instance_of Item, @i
  end

  def test_you_can_access_specifications
    assert_equal 123456, @i.id
    assert_equal 'Pencil', @i.name
    assert_equal 'You can use it to write things', @i.description
    assert_equal 0.1099, @i.unit_price
    assert_equal Time.parse('2016-01-11 11:51:36 UTC'), @i.created_at
    assert_equal Time.parse('2001-09-17 15:28:43 UTC'), @i.updated_at
  end

  def test_change_unit_price_to_dollars
    refute_equal @i.unit_price.inspect, '.1099'
    assert_equal @i.unit_price_to_dollars.inspect, 0.1099.inspect
  end
end
