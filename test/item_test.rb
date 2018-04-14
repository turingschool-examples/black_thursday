require './test/test_helper'
require './lib/item'
require './lib/item_repository'

class ItemTest < Minitest::Test
  attr_reader :i
  def setup
    @i = Item.new({ :id          => "3",
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => "1099",
                    :created_at  => Time.parse("2016-11-01 11:38:28 -0600"),
                    :updated_at  => Time.parse("2016-11-01 11:38:28 -0600")
                })

  end

  def test_it_exists
    assert_instance_of Item, i
  end

  def test_it_has_attributes
    expected = Time.parse('2016-11-01 11:38:28 -0600')

    assert_equal 3, i.id
    assert_equal 'Pencil', i.name
    assert_equal 'You can use it to write things', i.description
    assert_equal 10.99, i.unit_price
    assert_equal expected, i.created_at
    assert_instance_of Time, i.created_at
  end
end
