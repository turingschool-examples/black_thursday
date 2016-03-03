require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'bigdecimal'
require 'pry'
require 'date'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({
      id: "4",
      name: 'Pencil',
      description: 'You can use it to write',
      unit_price: "1200",
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1995-03-19 10:02:43 UTC',
      merchant_id: "12334105"
      })
  end

  def test_initalize_organizes_row_value_id
    assert_equal 4, @item.id
  end

  def test_initalize_organizes_row_value_name
    assert_equal "Pencil", @item.name
  end

  def test_initalize_organizes_row_value_description
    assert_equal "You can use it to write", @item.description
  end

  def test_initalize_organizes_row_value_unit_price
    assert @item.unit_price == 12.00
    assert_equal BigDecimal, @item.unit_price.class
  end

  def test_initalize_organizes_row_value_created_at
    assert_equal Time.parse("2016-01-11 11:51:37 UTC"), @item.created_at
  end

  def test_initalize_organizes_row_value_updated_at
    assert_equal Time.parse("1995-03-19 10:02:43 UTC"), @item.updated_at
  end

  def test_initalize_organizes_row_value_merchant_it
  end

  def test_returns_price_in_dollars_formatted_as_float
    assert_equal 12.00, @item.unit_price_per_dollars
  end
end
