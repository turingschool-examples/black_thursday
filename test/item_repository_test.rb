require "minitest/pride"
require "minitest/autorun"
require "./lib/item_repository"

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    assert_instance_of ItemRepository, item_repository
  end

  def test_item_repository_can_hold_items
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    assert_equal 5, item_repository.all.count
    assert item_repository.all.all? { |item| item.is_a?(Item)}
  end

  def test_item_repository_holds_item_attributes
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    assert_equal "510+ RealPush Icon Set", item_repository.all.first.name
    assert_equal 1200, item_repository.all.first.unit_price
  end

  def test_it_can_find_item_by_name
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    result = item_repository.find_by_name("510+ RealPush Icon Set")

    assert_instance_of Item, result
    assert_equal 1200, result.unit_price
    assert_equal "510+ RealPush Icon Set", result.name
  end

end
