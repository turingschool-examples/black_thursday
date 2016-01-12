require 'minitest'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({:name => "Pencil", :id => 3, :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC", :description => "You can use it to write things", :unit_price => BigDecimal.new(10.99,4)})
  end

  def test_item_can_be_initialized
    assert_equal Item, @item.class
  end

  def test_item_can_generate_an_id
    assert_equal 3, @item.id
  end

  def test_item_can_pull_a_name
    assert_equal "Pencil", @item.name
  end

  def test_item_can_pull_updated_at
    assert_equal "2012-03-27 14:53:59 UTC", @item.updated_at
  end

  def test_item_can_pull_created_at
    assert_equal "2012-03-27 14:53:59 UTC", @item.created_at
  end

  def test_item_can_pull_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_item_can_pull_unit_price
    assert_equal BigDecimal.new(10.99,4), @item.unit_price
  end
end
