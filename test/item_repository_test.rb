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
    skip
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

    assert_equal [i,i2], ir.find_all_with_description("write")
    assert_equal [i3], ir.find_all_with_description("compute")
  end

  def test_we_can_find_items_by_price
    skip
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

  def test_we_can_find_all_items_by_price_range
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
      :unit_price  => BigDecimal.new(87.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1
    })

    ir.add_item(i)
    ir.add_item(i2)
    ir.add_item(i3)

    assert_equal [i2,i3], ir.find_all_by_price_in_range(80..90)
    assert_equal [], ir.find_all_by_price_in_range(50..60)
  end

  def test_we_can_find_all_items_by_merchant_id
    skip
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
      :unit_price  => BigDecimal.new(87.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1
    })

    ir.add_item(i)
    ir.add_item(i2)
    ir.add_item(i3)

    assert_equal [i,i2], ir.find_all_by_merchant_id(2)
    assert_equal [], ir.find_all_by_merchant_id(3)
  end

  def test_we_can_create_new_item
    ir = ItemRepository.new
    i3 = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    ir.add_item(i3)
    i2 = ir.create({
      :id          => 3,
      :name        => "PC",
      :description => "You can use it to compute",
      :unit_price  => BigDecimal.new(87.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1
    })

    assert_equal 2, i2.id
    assert_equal "PC", i2.name
  end

  def test_we_can_update_item
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
      :unit_price  => BigDecimal.new(87.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1
    })

    ir.add_item(i)
    ir.add_item(i2)
    ir.add_item(i3)
    ir.update(3,{
      :id          => 3,
      :name        => "Laptop",
      :description => "You can use it to compute anywhere",
      :unit_price  => BigDecimal.new(100.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1
    })

    assert_equal "Laptop", i3.name
  end

  def test_we_can_delete_item
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
      :unit_price  => BigDecimal.new(87.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 1
    })

    ir.add_item(i)
    ir.add_item(i2)
    ir.add_item(i3)
    ir.delete(2)

    assert_equal [i,i3], ir.items

  end

end
