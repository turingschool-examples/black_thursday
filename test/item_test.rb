require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/merchant'
require './lib/item_repo'
require './lib/item'

class ItemTest < Minitest::Test

  def test_item_exists
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

  def test_item_attributes
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
    assert_instance_of BigDecimal, i.unit_price
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
    assert_equal 2, i.merchant_id
  end

  def test_unit_price_to_dollars
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
