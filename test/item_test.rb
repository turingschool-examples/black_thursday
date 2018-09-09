require_relative './test_helper'
require_relative '../lib/item'
require 'bigdecimal'

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
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    assert_equal 1, i.id
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal 10.99, i.unit_price
    assert_equal 2, i.merchant_id
  end

end
