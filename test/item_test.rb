require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({:id        => 263395237,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :merchant_id => 12334105,
                    :unit_price  => 1099,
                    :created_at  => "09:34:06 UTC",
                    :updated_at  => "2007-06-04 21:35:10 UTC"}, "ItemRepository")
  end

  def test_it_exist_with_attributes
    assert_instance_of Item, @item
    assert_equal 263395237, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_instance_of BigDecimal, @item.unit_price
    assert_instance_of Time, @item.created_at
    assert_instance_of Time, @item.updated_at
  end

  def test_item_can_return_prices_in_dollars
    assert_instance_of BigDecimal, @item.unit_price
    assert_equal 10.99, @item.unit_price_to_dollars
  end

  def test_item_knows_about_item_repo
    assert_equal "ItemRepository", @item.item_repo
  end

end
