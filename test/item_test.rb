require "minitest/autorun"
require "minitest/pride"
require "bigdecimal"
require_relative "../lib/item"


class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 12334141
      })
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_it_has_a_name
    assert_equal 'Pencil', item.name
  end

  def test_it_has_a_description
    assert_equal 'You can use it to write things', item.description
  end

  def test_it_has_a_unit_price
    assert_equal 10.99, item.unit_price
  end

  def test_it_knows_when_it_was_created_and_updated
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_it_knows_merchant_id
    assert_equal 12334141, item.merchant_id
  end
end
