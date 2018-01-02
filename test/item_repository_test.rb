require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require "minitest/autorun"
require "minitest/pride"
require "./lib/item_repository"
require "pry"

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    item = ItemRepository.new

    assert_instance_of ItemRepository, item
  end

  def test_items_is_filled
    item = ItemRepository.new

    assert_instance_of Item, item.items.first
    assert_instance_of Item, item.items.last
  end

  def test_it_returns_correct_id
    item = ItemRepository.new
    found_id = item.find_by_id("263395721")

    assert_equal "Disney scrabble frames", found_id.name
    assert_equal "12334185",found_id.merchant_id
    assert_equal "1350", found_id.unit_price
  end

  def test_it_returns_correct_name
    item = ItemRepository.new
    found_name = item.find_by_name("Disney scrabble frames")

    assert_equal "263395721", found_name.id
    assert_equal "12334185",found_name.merchant_id
    assert_equal "1350", found_name.unit_price
  end

  def test_it_finds_all_with_description
    item = ItemRepository.new
    found_descriptions = item.find_all_with_description('Pillow')

    assert_equal 14, found_descriptions.count # need to add new assertion 
  end

end
