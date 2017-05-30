require './test/test_helper'
require './lib/item.rb'

class ItemTest < Minitest::Test 
  def test_it_initializes_with_instance_variables
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.new(2016, 10, 31),
      :updated_at  => Time.new(2017, 10, 31)})
      
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 0.1099e2, item.unit_price
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end 
  
  def test_unit_price_to_dollars_returns_float
    item = Item.new({
      :unit_price  => BigDecimal.new(10.99,4)
      })
    
      assert_equal 10.99, item.unit_price_to_dollars
  end 
  
end 