require 'bigdecimal'
require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({  id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: BigDecimal.new(10.99,4),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 1
 })
  end

  def test_gives_its_id
    assert_equal 1, @item.id
  end

  def test_gives_its_name
    assert_equal "Pencil", @item.name
  end

  def test_gives_its_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_gives_its_price
    assert_equal BigDecimal.new(10.99,4), @item.unit_price
  end

  def test_gives_price_as_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end

  def test_prices_with_one_decimal_work
    item = Item.new({unit_price: BigDecimal.new(11.00,4)})
    assert_equal 11.00, item.unit_price_to_dollars
    item = Item.new({unit_price: BigDecimal.new(11.40,4)})
    assert_equal 11.40, item.unit_price_to_dollars
  end

  def test_gives_time_created
    skip
    time = Time.now
    item = Item.new({  id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: BigDecimal.new(10.99,4),
      created_at: time,
      updated_at: time,
      merchant_id: 1})
      assert_equal time, @item.created_at
  end

  def test_gives_time_updated
    skip
    time = Time.now
    item = Item.new({  id: 1,
      name: "Pencil",
      description: "You can use it to write things",
      unit_price: BigDecimal.new(10.99,4),
      created_at: time,
      updated_at: time,
      merchant_id: 1})
      assert_equal time, @item.updated_at
  end

  def test_gives_owners_merchant_id
    assert_equal 1, @item.merchant_id
  end
end
