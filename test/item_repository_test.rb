require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_can_return_all_items
    assert_equal 1367, @se.items.all.count
  end

  def test_it_finds_an_item_by_id
    item = @se.items.find_by_id(263538760)

    assert_equal 263538760, item.id
    assert_equal "Puppy blankie", item.name

    assert_nil @se.items.find_by_id(1)
  end

  def test_it_finds_an_item_by_name
    item = @se.items.find_by_name("Puppy blankie")

    assert_equal "Puppy blankie", item.name
    assert_equal 263538760, item.id

    assert_nil @se.items.find_by_name("Sales Engine")
  end
end
