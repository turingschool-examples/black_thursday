require './lib/business_data'
require './lib/item'
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'

class BusinessDataTest < Minitest::Test
  def setup
    @now = Time.now

    @item_1 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @now,
      :updated_at  => @now,
      :merchant_id => 2
    }

    @item_2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things neatly",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @now,
      :updated_at  => @now,
      :merchant_id => 2
    }
  end

  def test_it_compares_two_objects_that_are_the_same
    assert_equal Item.new(@item_1), Item.new(@item_1)
  end

  def test_it_compares_two_objects_that_are_different
    refute_equal Item.new(@item_1), Item.new(@item_2)
  end
end
