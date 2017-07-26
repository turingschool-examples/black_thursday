require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'

class ItemRepositoryTest < Minitest::Test

  def test_it_exist
    item_repo = ItemRepository.new("./data/items.csv", "engine")

    assert_instance_of ItemRepository, item_repo
  end

  def test_can_find_by_id
    item_repo = ItemRepository.new("./data/items.csv", "engine")
    id = 10

    assert_nil "zz09093480", item_repo.find_by_id(id)
    assert_instance_of Item, item_repo.find_by_id(id)
    assert_equal id, item_repo.find_by_id(id)
  end

  def test_it_can_find_by_name
    item_repo = ItemRepository.new("./data/items.csv", "engine")
    name = "Joey"

    assert_nil "zz09093480", item_repo.find_by_name(name)
    assert_instance_of Item, item_repo.find_by_name(name)
    assert_equal name, item_repo.find_by_name(name)
  end


end
