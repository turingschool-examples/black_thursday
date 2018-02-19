require_relative 'test_helper.rb'
require_relative '../lib/item_repository'

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
    assert_equal "1200", result.unit_price
    assert_equal "510+ RealPush Icon Set", result.name
  end

  def test_it_can_find_item_by_id
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    result = item_repository.find_by_id("263395617")

    assert_instance_of Item, result
    assert_equal "Glitter scrabble frames", result.name
    assert_equal "263395617", result.id
  end

  def test_it_can_find_all_with_description
    # skip
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    result = item_repository.find_all_with_description("Disney glitter frames")

    assert_instance_of Item, result
    assert_equal "1350", result.unit_price
    assert_equal "Disney scrabble frames", result.name
  end

  def test_it_can_find_all_by_price
    # skip
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    result = item_repository.find_all_by_price(700)

    assert_instance_of Item, result
    assert_equal 263396013, result.id
    assert_equal 700, result.unit_price
  end

  def test_it_can_find_all_by_price_range
    skip
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    result = item_repository.find_all_by_price((0..900))

    assert_instance_of Item, result
    assert_equal 700, result.unit_price
    assert_equal "Free standing Woden letters", result.name
  end

  def test_it_can_find_all_by_merchant_id
    skip
    item_repository = ItemRepository.new("./test/fixtures/items.csv")

    result = item_repository.find_by_merchant_id(12334105)

    assert_instance_of Item, result
    assert_equal 1200, result.unit_price
    assert_equal 12334105, result.merchant_id
  end
end
