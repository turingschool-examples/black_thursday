require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'pry'

class ItemTest < MiniTest::Test

  def test_it_exists
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 10,
      :created_at  => 10,
      :updated_at  => 10,
      })
    assert_instance_of Item, item
  end

  def test_does_it_initialize_with_name
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 10,
      :created_at  => 10,
      :updated_at  => 10,
      })
    assert_equal "Pencil", item.name
  end
end
