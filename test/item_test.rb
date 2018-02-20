require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test

  def setup
    data = {
      id:           "137519844",
      name:         "Pencil",
      description:  "You can use it to write things",
      unit_price:   BigDecimal.new(10.994, 4),
      created_at:   "2018-02-02 14:37:20 -0700",
      updated_at:   "2018-02-02 14:37:20 -0700",
      merchant_id:  "12334105"}
    @item = Item.new(data)
  end

  def test_if_it_exists
    assert_instance_of Item, @item
  end

  def test_if_it_has_attributes
    assert_equal 137519844, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_equal 0.1099e0, @item.unit_price
    assert @item.created_at.class == Time
    assert @item.updated_at.class == Time
    assert_equal 12334105, @item.merchant_id
  end

  def test_if_it_can_return_unit_price_in_dollars
    assert_equal "$0.1099", @item.unit_price_to_dollars
  end

end
