require 'bigdecimal'
require 'time'
require './lib/item'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({
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
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description_unit_price_created_at_updated_at
    assert_equal "You can use it to write things", @item.description
    assert_equal BigDecimal.new(10.99,4), @item.unit_price
    assert_instance_of Time, @item.created_at
    assert_instance_of Time, @item.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 12.00, item.unit_price_

end
