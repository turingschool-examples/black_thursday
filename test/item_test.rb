require './test/test_helper'
require './lib/item'
require 'bigdecimal'

class ItemTest < MiniTest::Test

  def setup
    @time = Time.now
    @item = Item.new({
      id: 321,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: 10.99,
      merchant_id: 426
    }, mock('ItemRepository'))
  end

  def test_it_has_an_id
    assert_equal 321, @item.id
  end

  def test_it_has_an_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_has_unit_price
    assert_equal 10.99, @item.unit_price
  end

  def test_it_has_created_at
    result = @item.created_at

    assert_equal Time.now.inspect, result.inspect
  end

  def test_it_has_updated_at
    result = @item.updated_at

    assert_equal Time.now.inspect, result.inspect
  end

  def test_it_has_merchant_id
    assert_equal 426, @item.merchant_id
  end

  def test_unit_price_in_dollars
    assert_equal 10.99, @item.unit_price_in_dollars
  end
end
