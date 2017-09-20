require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require 'pry'

class ItemTest < MiniTest::Test
  attr_reader :item

  def setup
    @item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1000,
      :created_at  => Time.parse("2016-12-30 10:12:12 -0600"),
      :updated_at  => Time.parse("2016-12-30 10:12:12 -0600"),
      })
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_does_it_initialize_with_name
    assert_equal "Pencil", item.name
  end

  def test_unit_price_to_dollars
    assert_equal 10.00, item.unit_price_to_dollars(1000)
  end

  def test_time_parse_methods_work
    expected = Time.parse("2016-12-30 10:12:12 -0600")

    assert_equal expected, item.created_at
    assert_equal expected, item.updated_at
  end
end
