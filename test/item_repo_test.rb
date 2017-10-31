require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require 'pry'

class ItemRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of ItemRepository, ItemRepository.new(self)
  end

  def test_it_can_create_item_instances
    item_repo = ItemRepository.new(self)

    assert_instance_of Item, item_repo.items.first
  end

  def test_it_can_reach_the_item_instances_through_all
    item_repo = ItemRepository.new(self)

    assert_instance_of Item, item_repo.all.first
  end

  def test_it_can_find_items_by_id
    item_repo = ItemRepository.new(self)
    results = item_repo.find_by_id("263396013")

    assert_equal "Free standing Woden letters", results.name
  end

  def test_it_can_find_items_by_name
    item_repo = ItemRepository.new(self)
    results = item_repo.find_by_name('Free standing Woden letters')

    assert_equal "263396013", results.id
  end

  #The method above does not result in an array

  def test_it_can_find_items_by_description
    item_repo = ItemRepository.new(self)
    description = "Free standing wooden letters \n\n15cm\n\nAny colours"
    results = item_repo.find_all_with_description(description)

    assert_equal "263396013", results.first.id
  end

end
