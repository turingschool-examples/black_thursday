require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    id: '263414049, name 'Snow fallen',"Snow fallen 10&quot;x10&quot;
Oil on canvas",50000,12334895,2016-01-11 15:21:02 UTC,1999-09-26 18:42:40 UTC'
  end

  def test_it_exists
    time = Time.new
    i = Item.new(
      id: '1',
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: 10.99,
      created_at: time,
      updated_at: time
    )

    assert_instance_of Item, i
  end

  def test_it_has_attributes
    time = Time.new
    i = Item.new(
      id: '1',
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: 10.99,
      created_at: time,
      updated_at: time
    )

    assert_equal 1, i.id
    assert_equal 'Pencil', i.name
    assert_equal 'You can use it to write things', i.description
    assert_equal 10.99, i.unit_price
    assert_equal time, i.created_at
    assert_equal time, i.updated_at
  end

  def test_it_has_integer_attributes
    time = Time.new
    i = Item.new(
      id: '1',
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: 10.99,
      created_at: time,
      updated_at: time
    )
      assert_equal 1, i.id
      assert_equal 'Pencil', i.name
      assert_equal 'You can use it to write things', i.description
      assert_equal 10.99, i.unit_price
      assert_equal time, i.created_at
      assert_equal time, i.updated_at
  end
end
