require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'pry'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({
      :name         => "Pencil",
      :description  => "You can use it to write things",
      :unit_price   => BigDecimal.new(10.99,4),
      :created_at   => Time.now,
      :updated_at   => Time.now
      })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_returns_item_price_as_bigdecimal
    assert_equal BigDecimal.new(10.99,4), @item.unit_price
  end

  def test_it_returns_time_information
    assert_instance_of Time, @item.created_at
    assert_instance_of Time, @item.updated_at
  end

  def test_it_gives_unit_price_in_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end

end
