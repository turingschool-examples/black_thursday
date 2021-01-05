require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/item'
require 'time'

class ItemTest < Minitest::Test

  def test_it_exist_and_has_attributes
    @time1 = Time.now
    @time2 = Time.now
    i = Item.new({
                    :id          => 2,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :merchant_id => 1,
                    :created_at  => @time1,
                    :updated_at  => @time2
                  })

    assert_instance_of Item, i
    assert_equal 2, i.id
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal BigDecimal.new(10.99,4), i.unit_price
    assert_equal 1, i.merchant_id
    assert_equal @time1, i.created_at
    assert_equal @time2, i.updated_at
  end

  def test_unit_price_to_dollars
    i = Item.new({
                  :id          => 2,
                  :name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :merchant_id => 1,
                  :created_at  => @time1,
                  :updated_at  => @time2
                })

    assert_equal 0.1099, i.unit_price_to_dollars
  end
end
