require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repo'

class ItemTest < Minitest::Test
    attr_reader :data,
                :parent,
                :item

  def setup
    @data = {
            :name        => "Pencil",
            :description => "You can use it to write things",
            :unit_price  => BigDecimal.new(10.99,4),
            :created_at  => Time.now,
            :updated_at  => Time.now,
            }
    @parent = Minitest::Mock.new
    @item = Item.new(data, parent)  
  end
 
  def test_it_exists
    assert_instance_of Item, item
  end

  def test_item_takes_in_proper_values
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal BigDecimal.new(10.99,4), item.unit_price 
    assert_equal Time.now, item.created_at
    assert_equal Time.now, item.updated_at 
  end
end