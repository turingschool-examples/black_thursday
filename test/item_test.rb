require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  attr_reader :item
  
  def setup
    @item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 2400,
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
  end

  def test_Item_exists
    assert Item.new({})
  end

  def test_item_knows_name
    assert_equal "Pencil", item.name
  end

  def test_item_knows_description
    assert_equal "You can use it to write things", item.description
  end

  def test_item_knows_unit_price
    assert_equal 2400, item.unit_price
  end

  def test_item_knows_time_created_at
    assert_equal Time.now.to_s, item.created_at.to_s
  end

  def test_item_knows_time_updated_at
    assert_equal Time.now.to_s, item.updated_at.to_s
  end

  def test_unit_price_to_dollars_returns_float_of_price
    assert_equal 24.00, item.unit_price_to_dollars
  end

end