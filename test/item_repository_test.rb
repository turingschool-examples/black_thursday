require 'test_helper'
require './lib/item_repository'
require './lib/item'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  def test_all_returns_array_of_instances
    ir = ItemRepository.new

     assert_equal 1, ir.all.count
  end

  def test_find_by_ID
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

    assert_equal i, ir.find_by_ID(1)
  end

  def test_find_by_name
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

    assert_equal i, ir.find_by_name("Pencil")
  end

  def test_find_all_with_description
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
    assert_equal i, ir.find_all_with_description("You can use it to write things")
  end

  def find_all_by_price
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
    assert_equal i, ir.find_all_by_price(BigDecimal.new(10.99,4))
  end

  def find_all_by_price_in_range
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
    assert_equal i, ir.find_all_by_price_in_range(1..11)
  end

  def find_all_by_merchant_id
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
    assert_equal i, ir.find_all_by_merchant_id(2)
  end

  def test_create
    ir = ItemRepository.new
    i = Item.new({
  :id          => 100,
  :name        => "Asa",
  :description => "My name",
  :unit_price  => BigDecimal.new(25.00, 4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 19
})
    assert_equal i, ir.create({
  :id          => 100,
  :name        => "Asa",
  :description => "My name",
  :unit_price  => BigDecimal.new(25.00, 4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 19
})
  end

  def test_update
    ir = ItemRepository.new
    i = Item.new({
  :id          => 1,
  :name        => "Pen",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 11
})

    assert_equal i, ir.update(1, {
  :name        => "Pen",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 11
})
  end

  def test_delete
    ir = ItemRepository.new

    assert_equal nil, ir.delete(1)
  end
end
