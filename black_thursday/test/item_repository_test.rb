require_relative 'test_helper'
require 'csv'
require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @repository = ItemRepository.new("./data/items.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @repository
  end

  def test_all_returns_all_items_from_repository

  end

  def test_it_can_find_by_id

  end

  def test_find_by_id_returns_nil_if_no_match_is_found

  end

  def test_find_test_by_name_find_matching_case_insensitive_name

  end

  def test_find_by_name_returns_nil_if_no_match_is_found

  end

  def test_find_all_by_description_returns_all_items_with_description_keyword

  end

  def test_test_all_returns_empty_array_if_no_match_is_found

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
