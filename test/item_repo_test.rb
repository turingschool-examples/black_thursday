require_relative 'test_helper'
require_relative "../lib/item_repo"

class ItemRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of ItemRepository, ItemRepository.new(self, "./data/items.csv")
  end

  def test_it_can_create_item_instances
    item_repo = ItemRepository.new(self, "./data/items.csv")

    assert_instance_of Item, item_repo.items.first
  end

  def test_it_can_reach_the_item_instances_through_all
    item_repo = ItemRepository.new(self, "./data/items.csv")

    assert_instance_of Item, item_repo.all.first
  end

  def test_it_can_find_items_by_id
    item_repo = ItemRepository.new(self, "./data/items.csv")
    results = item_repo.find_by_id(263396013)

    assert_equal "Free standing Woden letters", results.name
  end

  def test_it_can_find_items_by_name
    item_repo = ItemRepository.new(self, "./data/items.csv")
    results = item_repo.find_by_name('Free standing Woden letters')

    assert_equal 263396013, results.id
  end

  def test_find_by_name_can_return_an_empty_array
    item_repo = ItemRepository.new(self, "./data/items.csv")
    results = item_repo.find_by_name('Not A Real Product')

    assert_nil results
  end

  #The method above does not result in an array

  def test_it_can_find_items_by_description
    item_repo = ItemRepository.new(self, "./data/items.csv")
    description = "oil painting on stretched canvas 45x60 cm"
    results = item_repo.find_all_with_description(description)

    assert_equal 263399825, results.first.id
  end

  def test_it_can_find_all_by_merchant_id
    item_repo = ItemRepository.new(self, "./data/items.csv")
    results = item_repo.find_all_by_merchant_id(12334185)

    assert_equal 6, results.count
    assert_equal "Glitter scrabble frames", results.first.name
  end

  def test_it_can_find_all_by_price_in_range
    item_repo = ItemRepository.new(self, "./data/items.csv")

    assert_equal 1090, item_repo.find_all_by_price_in_range(1..100).count
  end
  #missing find_merchant test
  def test_can_find_by_price
    item_repo = ItemRepository.new(self, "./data/items.csv")
    results = item_repo.find_all_by_price(12)

    assert_equal "The Beatles Clock | Hecho a mano", results.first.name
    assert_equal "Abbey Road Clock | Hecho a mano", results.last.name
  end
end
