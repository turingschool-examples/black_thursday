require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    @item = Item.new({:id => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_an_id
    assert_equal 1, @item.id
  end

  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_has_a_unit_price
    assert_instance_of BigDecimal, @item.unit_price
  end

  def test_it_has_created_date
    assert_instance_of Time, @item.created_at
  end

  def test_it_has_updated_date
    assert_instance_of Time, @item.updated_at
  end

  def test_it_can_return_unit_price_to_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end

end
