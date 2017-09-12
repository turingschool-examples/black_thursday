require_relative 'test_helper'
require './lib/item'

class ItemsTest < Minitest::Test

  def test_it_exists
    item = {:name=>'Pencil', :description=>'You can use it to write things', :unit_price=>4.30, :created_at=>800, :updated_at=>805}

    assert_instance_of Item, Item.new(item)
  end

  def test_it_can_find_item_attributes
    item = {:name=>'Pencil', :description=>'You can use it to write things', :unit_price=>4300, :created_at=>800, :updated_at=>805}

    assert_nil(Item.new(item).id)
    assert_equal 'Pencil', Item.new(item).name
    assert_equal 'You can use it to write things', Item.new(item).description
    assert_equal BigDecimal.new(43.00, 4), Item.new(item).unit_price
    assert_equal 800, Item.new(item).created_at
    assert_equal 805, Item.new(item).updated_at
  end

end
