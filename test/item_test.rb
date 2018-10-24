require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test

  def test_that_it_exists
    skip
    item = Item.new

    assert_instance_of Item, item
  end

  def test_that_it_is_initialized_with_an_id_name_description_merchant_id
    item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :merchant_id => 2
      })

    assert_equal 1, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_equal 2, item.merchant_id
  end

  def test_that_it_is_initialized_with_Big_Decimal
    item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4)
      })

      assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_that_it_is_initialized_with_Time_class
    item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      #can we even test this?
      # :created_at  => Time.now,
      # :updated_at  => Time.now,
      })
      # assert_equal Time.now, item.created_at
    end

    def test_it_can_convert_unit_price_to_dollars
      item = Item.new({:unit_price  => BigDecimal.new(10.99,4)})
      #unit_price_to_dollars -
      #returns the price of the item in dollars formatted as a Float
      assert_equal "$10.99", item.unit_price_to_dollars
    end


end
