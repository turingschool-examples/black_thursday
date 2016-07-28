require './test/test_helper'
require './lib/item'
require 'bigdecimal'
require './lib/merchant'
require './lib/sales_engine'

class ItemTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./test/testdata/merchants_simple.csv",
    })
  end

  def test_we_can_instantiate_item_with_name
    i = Item.new({:name => "Pencil"}, @se.items)
    assert_equal "Pencil", i.name
  end

  def test_we_can_instantiate_item_with_different_name
    i = Item.new({:name => "Pen"}, @se.items)
    assert_equal "Pen", i.name
  end

  def test_can_instantiate_two_attributes
    i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
    }, @se.items)
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
  end

  def test_can_instantiate_time_object
    time = Time.parse("2016-01-11 09:34:06 UTC")
    i = Item.new({
      :created_at  => time
    }, @se.items)
    assert_equal Time, i.created_at.class
  end

  def test_can_instantiate_big_decimal_objects
    unit_price = BigDecimal.new(10.99,4)
    i = Item.new({
      :unit_price  => unit_price
    }, @se.items)
    assert_equal BigDecimal, i.unit_price.class
  end

  def test_can_instantiate_all_required_attributes
    data = {
      :id          => 263515792,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :merchant_id => 12334141,
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.parse("2016-01-11 09:34:06 UTC"),
      :updated_at  => Time.parse("2016-01-11 09:34:06 UTC")
    }
    i = Item.new(data, @se.items)
    assert_equal data[:id],           i.id
    assert_equal data[:name],         i.name
    assert_equal data[:description],  i.description
    assert_equal data[:merchant_id],  i.merchant_id
    assert_equal data[:unit_price],   i.unit_price
    assert_equal data[:created_at],   i.created_at
    assert_equal data[:updated_at],   i.updated_at
  end

  def test_unit_price_to_dollars_with_decimal_value
    data = {:unit_price  => BigDecimal.new(10.99,4)}
    i = Item.new(data, @se.items)
    assert_equal 10.99, i.unit_price_to_dollars
  end

  def test_unit_price_to_dollars_with_whole_value
    data = {:unit_price  => BigDecimal.new(12)}
    i = Item.new(data, @se.items)
    assert_equal 12.00, i.unit_price_to_dollars
  end

  def test_merchant_method_returns_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    item = se.find_all_items_by_merchant_id(12334132)[0]
    merchant = se.find_merchant_by_id(12334132)
    assert_equal merchant, item.merchant
  end
end
