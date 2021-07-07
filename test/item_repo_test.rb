require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repo'

class ItemRepoTest < MiniTest::Test
  attr_reader :items

  def setup
    @items = ItemRepo.new("./data/items.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepo, items
  end

  def test_all_returns_array_of_all_items
    assert_equal 1367, items.all.count
  end

  def test_find_by_id_returns_matching_id
    expected = "Linnen Tafelkleed &#39;Non posso vivere di vento&#39;"

    assert_equal expected, items.find_by_id(263405559).name
  end

  def test_find_by_id_returns_nil_if_no_match
    assert_nil items.find_by_id("xxxxxxxx")
  end

  def test_find_all_with_description_returns_all_with_match
    assert_equal 706, items.find_all_with_description("the").count
    assert_equal 706, items.find_all_with_description("THE").count
  end

  def test_find_all_with_description_returns_empty_array_if_no_match
    assert_equal [], items.find_all_with_description("xxxxxxxxx")
  end

  def test_find_all_by_price_returns_all_matches_with_exact_price
    assert_equal 6, items.find_all_by_price(0.12e3).count
  end

  def test_it_can_find_price_within_range
    range = (12..15)
    assert_equal 135, items.find_all_by_price_in_range(range).count
  end


end
