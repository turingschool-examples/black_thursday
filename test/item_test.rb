require './test/test_helper'
require './lib/item'
require './lib/item_repository'

class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new({:id          => "3",
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => "1099",
                      :created_at  => Time.parse("2016-11-01 11:38:28 -0600"),
                      :updated_at  => Time.parse("2016-11-01 11:38:28 -0600")
                      }, self)

  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_it_has_attributes
    expected = Time.parse('2016-11-01 11:38:28 -0600')

    assert_equal 3, item.id
    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal 10.99, item.unit_price
    assert_equal expected, item.created_at
    assert_instance_of Time, item.created_at
  end
end
