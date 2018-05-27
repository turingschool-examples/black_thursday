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

  def test_it_finds_all_items_matching_given_description
    description = "A large Yeti of sorts, casually devours a cow as the others watch numbly."
    items = @se.items.find_all_with_description(description)

    assert_equal 263550472, items.first.id
    assert_equal description, items.first.description

    description = "A LARGE yeti of SOrtS, casually devoURS a COw as the OTHERS WaTch NUmbly."
    items = @se.items.find_all_with_description(description)

    assert_equal 263550472, items.first.id


    description = "Sales Engine is a relational database"
    items = @se.items.find_all_with_description(description)

    assert_equal 0, items.length
  end

  def test_it_finds_all_items_matching_given_price
    price = BigDecimal.new(25)
    assert_equal 79, @se.items.find_all_by_price(price).length


    price = BigDecimal.new(10)
    assert_equal 63, @se.items.find_all_by_price(price).length

    price = BigDecimal.new(20000)
    assert_equal 0, @se.items.find_all_by_price(price).length
  end
end
