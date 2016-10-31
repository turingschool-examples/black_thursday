require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  attr_reader   :i

  def setup
    @i = Item.new({
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  def test_it_can_create_an_item
    assert i
  end

  def test_it_can_return_id
    skip
    ##Need to determine how this will be assigned
  end

  def test_it_can_return_name
    assert_equal "Pencil", i.name
  end

  def test_it_can_return_unit_price_as_big_decimal
    assert_equal 10.99, i.unit_price
    assert_instance_of BigDecimal, i.unit_price
  end

  def test_it_can_return_created_at_as_time
    skip
    ##Need to find a way to test this properly
    assert_instance_of Time, i.created_at
  end

  def test_it_can_return_updated_at_as_time
    skip
    ##Need to find a way to test this properly
    assert_instance_of Time, i.updated_at
  end

  def test_it_can_return_merchant_id
    skip
    ##Need to determine how this will be assigned
  end

  def test_it_can_return_price_in_dollars_as_float
    skip
    ##Need to determine what we need here
    assert_instance_of Float, i.unit_price_to_dollars
  end
end