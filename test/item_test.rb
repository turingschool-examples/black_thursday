require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'pry'
require 'bigdecimal'

class ItemTest < MiniTest::Test

  def test_it_can_be_created
    assert_instance_of Item, Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  })
  end

  def test_it_can_call_on_name
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    assert_equal "Pencil", item.name
  end

  def test_it_can_call_on_description
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    assert_equal "You can use it to write things", item.description
  end


  def test_it_can_call_on_unit_price
    item = Item.new({
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  # def test_it_can_call_on_created_at
  #   item = Item.new({
  #   :name        => "Pencil",
  #   :description => "You can use it to write things",
  #   :unit_price  => BigDecimal.new(10.99,4),
  #   :created_at  => Time.now,
  #   # :updated_at  => Time.now,
  #   })
  #
  #   assert_equal Time.now, item.created_at
  # end
  #
  # def test_it_can_call_on_updated_at
  #   item = Item.new({
  #   :name        => "Pencil",
  #   :description => "You can use it to write things",
  #   :unit_price  => BigDecimal.new(10.99,4),
  #   # :created_at  => Time.now,
  #   :updated_at  => Time.now,
  #   })
  #
  #   assert_equal Time.now, item.updated_at
  # end


end
