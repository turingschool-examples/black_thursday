require 'pry'

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < MiniTest::Test

  def test_if_create_class
    i = Item.new({:name        => "test",
                  :description => "test",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    assert_instance_of Item, i
  end

  def test_default_attributes_and_format
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    assert i.name
    assert_equal "Pencil", i.name
    assert i.description
    assert_equal "You can use it to write things", i.description
    assert i.unit_price
    assert_equal 0.1099E2, i.unit_price
    assert i.created_at
    assert i.updated_at
  end

  def test_one_item_id
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 }, 1)

   assert_equal 1, i.id
  end

  def test_can_create_two_item_ids
    i1 = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 }, 1)

    i2 = Item.new({:name        => "Pen",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(11.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 }, 2)
binding.pry
    assert_equal 1, i1.id
    assert_equal 2, i2.id
  end

  def test_if_creates_merchant_id
    i = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 }, 1, 321)

    assert_equal 321, i.merchant_id
  end

end
