require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  def test_item_class_exists
    result = Item.new(["toothbrush", "brush teeth", 3])
    assert_instance_of Item, result
  end

  def test_item_name
    new_instance = Item.new(["toothbrush", "brush teeth", 3])
    result = new_instance.name
    assert_equal "toothbrush", result
  end

  def test_item_description
    new_instance = Item.new(["toothbrush", "brush teeth", 3])
    result = new_instance.description
    assert_equal "brush teeth", result
  end

  def test_item_unit_price
    new_instance = Item.new(["toothbrush", "brush teeth", 3])
    result = new_instance.unit_price
    assert_equal 3, result
  end

end
