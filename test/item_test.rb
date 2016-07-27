require './test/test_helper'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def test_it_creates_new_item
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    assert_instance_of Item, item
  end

  def test_it_returns_item_name
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    assert_equal "Pencil", item.name
  end

  def test_it_returns_item_id
    item = Item.new({
      :id          => "263395237",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    assert_equal "263395237", item.id
  end

end
