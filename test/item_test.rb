require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    item = Item.new({
                    :id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => 10.99,
                    :created_at  => 10,
                    :updated_at  => 12,
                    :merchant_id => 2
                    })
    assert_instance_of Item, item
  end

  def test_readable_attributes
    item = Item.new({
                :id          => 1,
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => BigDecimal.new(10.99, 4),
                :created_at  => 10,
                :updated_at  => 12,
                :merchant_id => 2
                })
    assert_equal 1, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 0.1099e2, item.unit_price
    assert_equal 10, item.created_at
    assert_equal 12, item.updated_at
    assert_equal 2, item.merchant_id
  end

  def test_unit_price_to_dollars
    item = Item.new({
                :id          => 1,
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => BigDecimal.new(10.99, 4),
                :created_at  => 10,
                :updated_at  => 12,
                :merchant_id => 2
                })
    assert_equal 0.11, item.unit_price_to_dollars
  end
end
