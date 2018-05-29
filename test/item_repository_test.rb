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

  def test_it_returns_array_of_items_priced_within_givin_range
    range = (1000.00..1500.00)
    items = @se.items.find_all_by_price_in_range(range)

    assert_equal 19, items.length

    range = (10.00..150.00)
    items = @se.items.find_all_by_price_in_range(range)

    assert_equal 910, items.length

    range = (10.00..15.00)
    items = @se.items.find_all_by_price_in_range(range)

    assert_equal 205, items.length

    range = (0..10.0)
    items = @se.items.find_all_by_price_in_range(range)

    assert_equal 302, items.length
  end

  def test_it_returns_an_array_of_items_associated_with_given_merchant_id
    merchant_id = 12334326
    items = @se.items.find_all_by_merchant_id(merchant_id)

    assert_equal 6, items.length

    merchant_id = 12336020
    items = @se.items.find_all_by_merchant_id(merchant_id)

    assert_equal 2, items.length
  end

  def test_it_creates_a_new_item_instance
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }
    @se.items.create(attributes)
    item = @se.items.find_by_id(263567475)
    assert_equal "Capita Defenders of Awesome 2018", item.name
  end

  def test_it_can_update_item
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }
    @se.items.create(attributes)
    original_time = @se.items.find_by_id(263567475).updated_at
    attributes = {
      unit_price: BigDecimal.new(379.99, 5)
    }
    @se.items.update(263567475, attributes)
    item = @se.items.find_by_id(263567475)
    assert_equal 379.99, item.unit_price
    assert_equal "Capita Defenders of Awesome 2018", item.name
    assert item.updated_at > original_time
  end

  def test_it_deletes_an_item
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }
    @se.items.create(attributes)
    item = @se.items.find_by_id(263567475)
    assert_equal 263567475, item.id

    @se.items.delete(263567475)

    assert_nil @se.items.find_by_id(263567475)

    assert_nil @se.items.delete(270000000)
  end
end
