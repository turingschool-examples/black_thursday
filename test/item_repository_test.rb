require_relative 'test_helper'
require_relative "../lib/item_repository"


class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")

    assert_instance_of ItemRepository, item
  end

  def test_items_is_filled
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")

    assert_instance_of Item, item.items.first
    assert_instance_of Item, item.items.last
  end

  def test_it_returns_correct_id
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")
    found_id = item.find_by_id(263395721)

    assert_equal "Disney scrabble frames", found_id.name
    assert_equal 12334185,found_id.merchant_id
  end

  def test_it_returns_correct_name
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")
    found_name = item.find_by_name("Disney scrabble frames")

    assert_equal 263395721, found_name.id
    assert_equal 12334185,found_name.merchant_id
    assert_equal 0.135e2, found_name.unit_price
  end

  def test_it_finds_all_with_description
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")
    found_descriptions = item.find_all_with_description('Pillow')

    assert_equal 1, found_descriptions.count # need to add new assertion
  end

  def test_it_returns_empty_array_if_nothing_matches
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")
    found_descriptions = item.find_all_with_description('areguhaeig7324')

    assert_equal [], found_descriptions
  end

  def test_it_finds_all_by_price
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")
    price = item.find_all_by_price(12.00)

    assert_equal 1, price.count
    assert_instance_of Item, price.first
    assert_instance_of Item, price.last
  end

  def test_it_finds_all_within_price_range
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")
    price_range = item.find_all_by_price_in_range(10..20)

    assert_equal 4, price_range.count
    assert_instance_of Item, price_range.first
    assert_instance_of Item, price_range.last
  end

  def test_it_finds_by_merchant_id
    item = ItemRepository.new("./test/fixtures/items_sample.csv", "se")
    merchants_inventory = item.find_all_by_merchant_id(12334195)

    assert_equal 10, merchants_inventory.count
    assert_instance_of Item, merchants_inventory.first
  end

end
