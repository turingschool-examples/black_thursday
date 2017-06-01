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
      :unit_price  => 1099,
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
    assert_equal 1099, item.unit_price
  end

  def test_it_knows_when_it_was_created_and_updated
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_it_knows_merchant_id
    assert_equal 12334141, item.merchant_id
  end

  def test_it_can_convert_to_dollars
    assert_equal 10.99, item.unit_price_to_dollars
  end

  def test_it_can_have_other_values
    item2 = Item.new({
      name: "Eraser",
      description: "You can use it to erase things.",
      unit_price: 300,
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 12341234
      })

    assert_equal "Eraser", item2.name
    assert_equal "You can use it to erase things.", item2.description
    assert_equal 300, item2.unit_price
    assert_instance_of Time, item2.created_at
    assert_instance_of Time, item2.updated_at
    assert_equal 3.00, item2.unit_price_to_dollars
  end
end
