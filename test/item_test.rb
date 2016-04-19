require "minitest/autorun"
require "./lib/item"
require "csv"

class ItemTest < Minitest::Test

def test_it_exists
  i = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })
  assert item
  # assert se.items.include?("id,name,description")
end

def test_it_has_a_name
  i = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })
  assert_equal "Pencil", item.name
  # assert se.items.include?("id,name,description")
end

def test_it_has_a_description
  i = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })
  assert_equal Array, item.description.class
  # assert se.items.include?("id,name,description")
end
