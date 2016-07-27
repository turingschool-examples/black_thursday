require './test/test_helper'
require './lib/item'
require 'BigDecimal'

class ItemTest < Minitest::Test

  def test_it_exists
    assert Item.new
  end

  def test_it_creates
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    assert_instance_of Item, item
  end
end
