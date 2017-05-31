require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository.rb'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def test_item_repository_exists
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_instance_of ItemRepository, item_repo
  end

  def test_item_repository_has_a_populated_items_array
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.items.length, 1367
  end

  def test_item_repository_can_be_populated
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_instance_of Item, item_repo.items[263395237]
  end

  def test_item_find_all
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.all, item_repo.items.values
  end

  def test_item_find_by_id
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_instance_of Item, item_repo.find_by_id(263395237)
  end

  def test_item_find_by_name
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_instance_of Item, item_repo.find_by_name("510+ RealPush Icon Set")
  end

  def test_item_find_by_name_with_nil
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_nil item_repo.find_by_name("Katie")
  end

  def test_find_all_with_description
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.find_all_with_description("frames").length, 7
  end

  def test_find_all_with_description_with_nil
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.find_all_with_description("asjdhasuhkjdnas"), []
  end

  def test_find_all_by_price
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.find_all_by_price(400.00).length, 7
  end

  def test_find_all_by_price_with_nil
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.find_all_by_price(12938012983.00), []
  end

  def test_find_all_by_price_in_range
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.find_all_by_price_in_range(10..20).length, 317
  end

  def test_find_all_by_price_in_range_with_nil
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.find_all_by_price_in_range(0..0), []
  end

  def test_find_all_by_merchant_id
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.find_all_by_merchant_id("12334141").length, 1
  end

  def test_find_all_by_merchant_id_with_nil
    csv_file = "./data/items.csv"
    item_repo = ItemRepository.new(csv_file)
    assert_equal item_repo.find_all_by_merchant_id("kwjalkdwja"), []
  end

end
