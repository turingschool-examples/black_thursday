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
        :unit_price  => BigDecimal.new(7.50,1),
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
        :unit_price  => BigDecimal.new(7.50,1),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 5
        })
    ir.add_individual_item(i1)
    ir.add_individual_item(i2)
    assert_equal i2, ir.find_by_id(2)
  end


end
