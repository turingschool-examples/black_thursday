require './test/test_helper'
require 'bigdecimal'
SimpleCov.start
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @time = Time.now
  end 
  def test_it_exists
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => @time,
      :updated_at  => @time,
    })

    assert_instance_of Iterm, item
  end 
  def test_it_has_attributes
    item = Item.new({
      :name        => 'Pencil',
      :description => 'You can use it to write things',
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => @time,
      :updated_at  => @time,
    })
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 10.99, item.unit_price
    assert_equal @time, item.created_at
    assert_equal @time, item.updated_at
  end 
end 