require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/cleaner'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => 10,
      :updated_at  => 12,
      :merchant_id => 2
      })
      @cleaner = Cleaner.new
  end

  def test_it_exists_with_attributes
    assert_instance_of Item, @item
    assert_equal 1, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_equal 0.1099e2, @item.unit_price
    assert_equal 10, @item.created_at
    assert_equal 12, @item.updated_at
    assert_equal 2, @item.merchant_id
  end
  
  def test_unit_price_to_dollars
    assert_equal 0.11, @item.unit_price_to_dollars
  end
end
