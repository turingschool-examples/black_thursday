require "./test/test_helper"
require "./lib/item"

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    item_hash = {
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => 11,
                    :updated_at  => 12,
                  }
    @item = Item.new(item_hash)
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_item_has_a_name
    assert_equal "Pencil", item.name
  end

  def test_item_has_a_description
    assert_equal "You can use it to write things", item.description
  end

  def test_item_has_a_unit_price
    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_item_has_created_at_time
    assert_equal 11, item.created_at
  end

  def test_item_has_updated_at_time
    assert_equal 12, item.updated_at
  end

end
