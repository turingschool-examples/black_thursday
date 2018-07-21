require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({
      :id          => 44,
      :name        => "Pencil",
      :description => "You can use it to write things.",
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1234566
    })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_attributes
    assert_equal 44, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things.", @item.description
    assert_equal 10.99, @item.unit_price
    assert_instance_of Time, @item.created_at
    assert_instance_of Time, @item.updated_at
    assert_equal 1234566, @item.merchant_id
  end

  def test_it_can_return_unit_price_as_dollas
    assert_equal 10.99, @item.unit_price_to_dollars
  end
end
