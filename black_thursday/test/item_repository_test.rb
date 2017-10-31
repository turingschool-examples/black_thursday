require_relative 'test_helper'
require 'csv'
require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :repository

  def setup
    @repository = ItemRepository.new("./data/items.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepository, @repository
  end

  def test_returns_all_items_from_repository
    assert_equal 1367, @repository.all.count
  end

  def test_it_can_find_by_id
    assert_equal Item, repository.find_by_id(263420519).class
    assert_equal "Custom Puppy Water Colors", repository.find_by_id(263420519).name
    assert_instance_of Time, repository.find_by_id(263420519).created_at
  end

  def test_find_by_id_returns_nil_if_no_match_is_found
    assert_nil repository.find_by_id(987654321)
    assert_nil repository.find_by_id("smush mahn")
  end

  def test_find_test_by_name_find_matching_case_insensitive_name
    assert_equal Item, repository.find_by_name("Custom Puppy Water Colors").class
    assert_equal "Custom Puppy Water Colors", repository.find_by_name("Custom Puppy Water Colors").name
    assert_instance_of Time, repository.find_by_name("Custom Puppy Water Colors").created_at
  end

  def test_find_by_name_returns_nil_if_no_match_is_found
    assert_nil repository.find_by_name(["abc"])
    assert_nil repository.find_by_name("Rare Custom Puppies")
  end

  def test_find_all_by_description_returns_all_items_with_description_keyword
    expected = "clear quartz chakra stone pendulum"
    actual = repository.find_all_with_description("onyx")

    assert_equal Array, actual.class
    assert_equal Item, actual.first.class
    assert_equal "Chalcedony", actual[1].name
    assert_equal expected, actual[-2].name
  end

  def test_test_all_returns_empty_array_if_no_match_is_found
    actual = repository.find_all_with_description("nothing!")

    assert_equal [], actual
    assert_equal [], repository.find_all_with_description(nil)
  end

  def test_find_all_by_price_returns_items_with_matching_price

  end

  def test_find_all_by_price_returns_empty_array_when_no_match_is_found

  end

  def test_find_all_by_price_in_range

  end

  def test_find_all_by_price_in_range_returns_empty_array_when_no_match_is_found

  end

  def test_can_find_all_items_by_merchant_id

  end

  def test_find_all_by_merchant_id_returns_empty_array_when_no_match_is_found

  end

  def test_inspect_returns_rows_in_repository

  end
end
