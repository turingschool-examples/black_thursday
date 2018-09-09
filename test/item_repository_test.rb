require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/item'
require 'bigdecimal'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_it_can_return_all_items
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    assert_equal [i1, i2], ir.all
  end

  def test_it_can_find_by_id
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    assert_equal i2, ir.find_by_id(2)
    assert_equal i1, ir.find_by_id(1)
  end

  def test_it_can_find_by_name
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    assert_equal i2, ir.find_by_name("Notebook")
    assert_equal i1, ir.find_by_name("Pencil")
  end

  def test_it_can_find_all_by_description
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    assert_equal [i2], ir.find_all_with_description("on")
    assert_equal [i1], ir.find_all_with_description("things")
    assert_equal [i1, i2], ir.find_all_with_description("write")
  end

  def test_it_can_find_all_by_price
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    assert_equal [i2], ir.find_all_by_price(7.50)
    assert_equal [i1], ir.find_all_by_price(10.99)
  end

  def test_it_can_find_all_by_in_range
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    assert_equal [i2], ir.find_all_by_price_in_range(7..8)
    assert_equal [i1], ir.find_all_by_price_in_range(10..11)
    assert_equal [i1, i2], ir.find_all_by_price_in_range(7..11)
  end

  def test_it_can_find_all_by_merchant_id
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    assert_equal [i2], ir.find_all_by_merchant_id(5)
    assert_equal [i1], ir.find_all_by_merchant_id(2)
  end

  def test_it_can_create_item
    ir = ItemRepository.new("./data/items.csv")
    i3 = ir.create({
      :name        => "Marker",
      :description => "You can use it to write things in color!",
      :unit_price  => BigDecimal.new(4.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 6
      })

    expected = ir.find_by_id(1)
    assert_equal expected, ir.find_by_name("Marker")
  end

  def test_it_can_update_attributes
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    hash_2 = {
        :id          => 5,
        :name        => "Sparkly Notebook",
        :description => "You can use it to write on and it sparkles.",
        :unit_price  => BigDecimal.new(9.01,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 9
        }
        ir.update(2, hash_2)
    assert_equal "Sparkly Notebook", i2.name
    assert_equal "You can use it to write on and it sparkles.", i2.description
    assert_equal 9.01, i2.unit_price
    refute_equal 5, i2.id
  end

  def test_it_can_delete_items
    ir = ItemRepository.new("./data/items.csv")
    i1 = Item.new({
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
        :name        => "Notebook",
        :description => "You can use it to write on",
        :unit_price  => BigDecimal.new(7.50,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    ir.delete(2)
    assert_nil ir.find_by_id(2)
  end


end
