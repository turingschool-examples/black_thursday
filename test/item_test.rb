require "minitest/autorun"
require "./lib/item"
require "csv"
require "bigdecimal"

class ItemTest < Minitest::Test

  def setup
    @time = "2007-06-04 21:35:10 UTC"
    @i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "10.99",
      :created_at  => @time,
      :updated_at  => @time,
    })
  end

  def test_it_exists
    assert @i
  end

  def test_it_has_attributes
    assert_equal "Pencil", @i.name
    assert_equal "You can use it to write things", @i.description
    assert_equal BigDecimal.new(10.99, 6)/100, @i.unit_price
    assert_equal Time.parse(@time), @i.created_at
    assert_equal Time.parse(@time), @i.updated_at
  end

  def test_if_can_convert_price_to_dollars
    assert_kind_of Float, @i.unit_price_to_dollars
  end

end
