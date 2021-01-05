require 'time'
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/items'


class ItemTest < Minitest::Test

  def setup
    @data = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99,4),
      :merchant_id => 2,
      :created_at => Time.now,
      :updated_at => Time.now})
  end

  def test_it_exists
    assert_instance_of Item, @data
  end

  def test_it_has_attributes
    assert_equal 1, @data.id
    assert_equal "Pencil", @data.name
    assert_equal "You can use it to write things", @data.description
    assert_equal 10.99, @data.unit_price
    assert_equal 2, @data.merchant_id
    assert_instance_of Time, @data.created_at
    assert_instance_of Time, @data.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, @data.unit_price_to_dollars
  end
end
