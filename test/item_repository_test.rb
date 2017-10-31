require_relative 'test_helper'
require_relative '../lib/item_repository'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_repo_pulls_in_CSV_info_from_items
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 1367, ir.from_csv("./data/items.csv").count
  end

  def test_it_returns_array_of_all_items
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 1367, ir.all.count
  end

  def test_find_by_id
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Item, ir.find_by_id
    assert_equal 263395237, ir.find_by_id.id
  end

  def test_it_can_find_by_name
    ir = ItemRepository.new("./data/items.csv")

    assert_equal "Vogue Paris Original Givenchy", ir.find_by_name.name
  end

  def test_it_can_find_all_with_description
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Array, ir.find_all_with_description
    assert_equal 1, ir.find_all_with_description.count
  end

  def test_it_can_find_all_by_price
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Array, ir.find_all_by_price
    assert_equal 13.50, ir.find_all_by_price[3].unit_price
  end

  def test_it_can_find_all_by_price_range
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Array, ir.find_all_by_price_in_range
    assert_equal 2, ir.find_all_by_price_in_range.count
  end
  def test_it_can_find_all_by_merchant_id
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of Array, ir.find_all_by_mercahnt_id
    assert_equal 1, ir.find_all_by_mercahnt_id.count
  end
end
