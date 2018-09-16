require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/item'

class ItemsTest < Minitest::Test

  def setup
    @i = Item.new({
      :id => 1,
      :name => "Gretchen Weiners lightsaber",
      :description => "Says 'you can't sit with us!' instead of ligthsaber sounds",
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
      })
  end

  def test_it_exists
    assert_instance_of Item, @i
  end

  def test_it_has_attributes
    assert_equal 1, @i.id
    assert_equal "Gretchen Weiners lightsaber", @i.name
    assert_equal "Says 'you can't sit with us!' instead of ligthsaber sounds", @i.description
    assert_equal BigDecimal.new(10.99, 4), @i.unit_price
    assert_instance_of Time, @i.created_at
    assert_instance_of Time, @i.updated_at
    assert_equal 2, @i.merchant_id
  end

  def test_the_unit_price_goes_to_dollhairs_correctly
    assert_equal 10.99, @i.unit_price_to_dollars
  end

end
