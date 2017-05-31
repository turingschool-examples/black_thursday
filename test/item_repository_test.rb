require 'pry'

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemRepositoryTest < MiniTest::Test

  def test_if_create_class
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  def test_initialize
    ir = ItemRepository.new

    assert_equal [], ir.all
  end

  def test_if_all_returns_array_of_instances
    ir = ItemRepository.new
    i1 = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    i2 = Item.new({:name        => "Pen",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(11.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })
    ir.all << i1
    ir.all << i2

    assert_equal 2, ir.all.length
  end

  def test_if_find_by_id_returns_correct_value_for_method
    ir = ItemRepository.new
    i1 = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    i2 = Item.new({:id         => 2,
                  :name        => "Pen",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(11.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })
    ir.all << i1
    ir.all << i2

    assert_equal i2, ir.find_by_id(2)
    assert_nil ir.find_by_id(3)
  end

  def test_find_by_name_returns_correct_value_for_method
    ir = ItemRepository.new
    i1 = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    i2 = Item.new({:name        => "Pen",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(11.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })
    ir.all << i1
    ir.all << i2

    assert_equal i2, ir.find_by_name('pen')
    assert_nil ir.find_by_name('Crayon')
  end

  def test_find_all_with_description_returns_correct_value_for_method
    ir = ItemRepository.new
    i1 = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    i2 = Item.new({:name        => "Pen",
                  :description => "Empty",
                  :unit_price  => BigDecimal.new(11.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })
    ir.all << i1
    ir.all << i2

    actual_1 = ir.find_all_with_description("You can use it to write things")
    actual_2 = ir.find_all_with_description("This description doesn't exist")
    assert_equal [i1], actual_1
    assert_equal [], actual_2
  end

  def test_find_all_by_price
    ir = ItemRepository.new
    i1 = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    i2 = Item.new({:name        => "Pen",
                  :description => "Empty",
                  :unit_price  => BigDecimal.new(11.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })
    ir.all << i1
    ir.all << i2

    assert_equal [i1], ir.find_all_by_price(0.1099E2)
    assert_equal [], ir.find_all_by_price(0.1515E2)
  end

  def test_find_all_by_price_in_range_returns_two_items
    ir = ItemRepository.new
    i1 = Item.new({:name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    i2 = Item.new({:name        => "Pen",
                  :description => "Empty",
                  :unit_price  => BigDecimal.new(11.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })
    ir.all << i1
    ir.all << i2

    actual_1 = ir.find_all_by_price_in_range((10..12))
    actual_2 = ir.find_all_by_price_in_range((1..4))

    assert_equal [i1, i2], actual_1
    assert_equal [], actual_2
  end

  def test_find_all_by_merchant_id
    ir = ItemRepository.new
    i1 = Item.new({:id         => 1,
                  :merchant_id => 11,
                  :name        => "Pencil",
                  :description => "You can use it to write things",
                  :unit_price  => BigDecimal.new(10.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })

    i2 = Item.new({:id         => 2,
                  :merchant_id => 11,
                  :name        => "Pen",
                  :description => "Empty",
                  :unit_price  => BigDecimal.new(11.99,4),
                  :created_at  => Time.now,
                  :updated_at  => Time.now
                 })
    ir.all << i1
    ir.all << i2

    actual_1 = ir.find_all_by_merchant_id(11)
    actual_2 = ir.find_all_by_merchant_id(12)

    assert_equal [i1, i2], actual_1
    assert_equal [], actual_2

  end

end
