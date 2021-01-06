require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/item'
require 'time'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def test_it_exist_and_has_attributes
    # @time1 = Time.now
    # @time2 = Time.now
    # require "pry"; binding.pry
    i = Item.new({
                    :id          => 2,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :merchant_id => 1,
                    :created_at  => '2021-01-06 11:29:55 UTC',
                    :updated_at  => '2021-01-06 11:29:55 UTC'
                  })

    assert_instance_of Item, i
    assert_equal 2, i.id
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal (0.10), i.unit_price
    assert_equal 1, i.merchant_id
    assert_equal Time.parse('2021-01-06 11:29:55 UTC'), i.created_at
    assert_equal Time.parse('2021-01-06 11:29:55 UTC'), i.updated_at
  end

  def test_unit_price_to_dollars
    # skip
    # @time1 = Time.now
    # @time2 = Time.now
    i = Item.new({
                  :id          => 2,
                  :name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal(10.99,4),
                  :merchant_id => 1,
                  :created_at  => '2021-01-06 11:29:55 UTC',
                  :updated_at  => '2021-01-06 11:29:55 UTC'
                })

    assert_equal (0.10), i.unit_price_to_dollars
  end

  def test_it_can_hold_diff_attributes
    # skip
    i2 = Item.new({
                    :id          => 5,
                    :name        => "Drawer",
                    :description => "Place to put stuff in",
                    :unit_price  => BigDecimal.new(12000),
                    :merchant_id => 10,
                    :created_at  => "2018-10-10 21:00:10 UTC",
                    :updated_at  => "2000-11-11 11:08:03 UTC"
                  })
      assert_equal 5, i2.id
      assert_equal "Drawer", i2.name
      assert_equal "Place to put stuff in", i2.description
      assert_equal BigDecimal(120), i2.unit_price
      assert_equal 10, i2.merchant_id
      assert_equal Time.parse('2018-10-10 21:00:10 UTC'), i2.created_at
      assert_equal Time.parse('2000-11-11 11:08:03 UTC'), i2.updated_at
    end

  def test_new_unit_price
    # skip
    i2 = Item.new({
                    :id          => 5,
                    :name        => "Drawer",
                    :description => "Place to put stuff in",
                    :unit_price  => BigDecimal(12000),
                    :merchant_id => 10,
                    :created_at  => '2018-10-10 21:00:10 UTC',
                    :updated_at  => '2000-11-11 11:08:03 UTC'
                  })
      assert_equal BigDecimal(120), i2.unit_price_to_dollars
  end

end
