require 'minitest/autorun'
require 'minitest/pride'
require './lib/item.rb'
require './test/test_helper.rb'

class ItemTest < Minitest::Test
  def setup
    @item = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      }
      @parent = ""
  end
  
  def test_it_exists
    assert_instance_of Item, Item.new(@item, @parent)
  end

  def test_it_names
    item = Item.new(@item, @parent)
    assert_equal "Pencil", item.name
  end

  def test_it_describes
    item = Item.new(@item, @parent)
    assert_equal "You can use it to write things", item.description
  end

  def test_it_creates_at_time
    item = Item.new(@item, @parent)
    time = Time.now
    assert_equal time, item.created_at
  end

  def test_it_updates_at_time
    item = Item.new(@item, @parent)
    time = Time.now
    assert_equal Time, item.updated_at
  end
end