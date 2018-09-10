require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'pry'
require 'bigdecimal'
require 'time'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  def test_it_defaults_empty
    ir = ItemRepository.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                  })

    assert_equal [], ir.items
  end

  def test_we_can_add_items_to_repo
    ir = ItemRepository.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                  })

    ir.add_item(i)



    assert_equal [i], ir.items
  end

  def test_we_can_return_all_items
    ir = ItemRepository.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    i2 = Item.new({
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    ir.add_item(i)
    ir.add_item(i2)

    assert_equal [i,i2], ir.all
  end

  def test_we_can_find_items_by_id
    ir = ItemRepository.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    i2 = Item.new({
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(88.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    ir.add_item(i)
    ir.add_item(i2)

    actual = ir.find_by_id(2)

    assert_equal "Pen", actual.name
  end

  def test_we_can_find_items_by_name
    ir = ItemRepository.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    i2 = Item.new({
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(88.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    ir.add_item(i)
    ir.add_item(i2)

    actual = ir.find_by_name("Pen")

    assert_equal 2, actual.id
  end

  def test_we_can_find_items_by_description
    ir = ItemRepository.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    i2 = Item.new({
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(88.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    i3 = Item.new({
      :id          => 3,
      :name        => "PC",
      :description => "You can use it to compute",
      :unit_price  => BigDecimal.new(88.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1
    })

    ir.add_item(i)
    ir.add_item(i2)
    ir.add_item(i3)

    assert_equal [i,i2], ir.find_by_description("write")
    assert_equal [i3], ir.find_by_description("compute")
  end

  def test_we_can_find_items_by_price
    ir = ItemRepository.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
    i2 = Item.new({
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(88.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    i3 = Item.new({
      :id          => 3,
      :name        => "PC",
      :description => "You can use it to compute",
      :unit_price  => BigDecimal.new(88.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1
    })

    ir.add_item(i)
    ir.add_item(i2)
    ir.add_item(i3)

    assert_equal [i2,i3], ir.find_all_by_price(88.99)
    assert_equal [i], ir.find_all_by_price(10.99)
  end

end
