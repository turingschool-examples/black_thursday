
require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def setup
    @time = Time.now
    @i = Item.new({
      :id          => 3,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @time,
      :updated_at  => @time,
      :merchant_id => 7
      })
  end

  def test_it_exists
    assert_instance_of Item, @i
  end

  def test_it_has_attributes
    assert_equal 3, @i.id
    assert_equal "Pencil", @i.name
    assert_equal "You can use it to write things", @i.description
    assert_equal BigDecimal.new(10.99,4), @i.unit_price
    assert_equal @time, @i.created_at
    assert_equal @time, @i.updated_at
    assert_equal 7, @i.merchant_id
  end

  def test_it_returns_unit_price_to_dollars
    dollars = @i.unit_price_to_dollars
    assert_instance_of Float, dollars
    assert_equal 10.99, dollars
  end

end
