require 'bigdecimal'
require_relative './test_helper'
require_relative '../lib/merchant'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })

      assert_instance_of Item, i
  end

  def test_it_has_attributes
    time = Time.now
    price = BigDecimal.new(10.99,4)
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => price,
      :created_at  => time,
      :updated_at  => time,
      :merchant_id => 2
    })

    assert_equal 1, i.id
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal price, i.unit_price
    assert_equal time, i.created_at
    assert_equal time, i.updated_at
    assert_equal 2, i.merchant_id
  end

  def test_it_can_convert_unit_price_to_dollars
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    assert_equal 10.99, i.unit_price_to_dollars
  end

end
