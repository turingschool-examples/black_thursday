require_relative 'test_helper'
require './lib/item'

class ItemsTest < Minitest::Test

  def test_it_exists
    item = {:name=>'Pencil', :description=>'You can use it to write things', :unit_price=>4.30, :created_at=>800, :updated_at=>805}

    assert_instance_of Item, Item.new(item)
  end

  def test_it_can_find_item_attributes
    characteristics = {:name=>'Pencil', :description=>'You can use it to write things', :unit_price=>4300, :created_at=>800, :updated_at=>805}
    item = Item.new(characteristics)

    assert_nil(item.id)
    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal BigDecimal.new(43.00, 4), item.unit_price
    assert_equal 800, item.created_at
    assert_equal 805, item.updated_at
  end

  def test_it_can_format_item_price_as_big_decimal
    characteristics = {:name=>'Pencil', :description=>'You can use it to write things', :unit_price=>4300, :created_at=>800, :updated_at=>805}
    item = Item.new(characteristics)

    assert_equal 0.43e2, item.unit_price
    assert_equal 43, item.unit_price
  end

end
