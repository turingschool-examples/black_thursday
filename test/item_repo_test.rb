require './test/test_helper'
require './lib/item_repo'

class ItemRepositoryTest < Minitest::Test

  def test_it_exist
    item_repo = ItemRepository.new("./data/items.csv", "engine")

    assert_instance_of ItemRepository, item_repo
  end

  def test_can_find_by_id
    item_repo = ItemRepository.new("./data/items.csv", "engine")
    id = 263395237

    assert_instance_of Item, item_repo.find_by_id(id)
  end

  def test_can_return_nil_if_id_invalid
    item_repo = ItemRepository.new("./data/items.csv", "engine")

    assert_nil item_repo.find_by_id("zz09093480")
  end

  def test_it_can_find_by_name
    item_repo = ItemRepository.new("./data/items.csv", "engine")
    name = "510+ RealPush Icon Set"

    assert_instance_of Item, item_repo.find_by_name(name)
  end

  def test_can_return_nil_if_name_invalid
    item_repo = ItemRepository.new("./data/items.csv", "engine")

    assert_nil item_repo.find_by_name("zz09093480")
  end

  def test_it_can_find_by_description
  end

end
