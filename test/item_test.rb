require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_reader :item

  def setup
    @item = Item.new({
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => BigDecimal.new(10.99,4),
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id    => 12334105
                    }, self)
  end

  def test_it_starts_an_item_instance
    assert_instance_of Item, @item
  end

  def test_attr_reader_works
    assert_equal "Pencil", @item.name
  end

  def test_attr_reader_works_for_other_attributes
    assert_equal "0.1099E2", @item.unit_price.to_s
  end

  def test_instance_created_at_works
    actual = @item.created_at.class
    expected = Time

    assert_equal expected, actual
  end

  def test_it_returns_the_unit_price_to_dollars
    assert_equal "10.99", @item.unit_price_to_dollars
  end

  def test_merchant_method_can_be_called
    actual = @item.merchant
    expected = 12334105

    assert_equal expected, actual
  end
end
