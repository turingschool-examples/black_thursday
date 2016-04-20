require './test/test_helper'
require './lib/item_repository'
require './lib/sales_engine'


class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repo, :se
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
    @se.items
    @item_repo = @se.item_repository
  end

  def test_all_returns_array
    assert_equal Array, item_repo.all.class
  end

  def test_returns_all_items_within_array
    assert_equal 19, item_repo.all.length
  end

  def test_all_returns_array_of_item_objects
    assert_equal Item, item_repo.all[7].class
  end

  def test_find_by_id_nil_for_a_unmatched_ID
    assert_equal nil, item_repo.find_by_id(6)
  end

  def test_find_by_id_returns_item_obj_upon_match
    assert_equal "Free standing Woden letters", item_repo.find_by_id(263396013).name
  end

  def test_find_by_name_nil_when_no_match
    assert_equal nil, item_repo.find_by_name("fake")
  end

  def test_find_by_name_returns_merch_obj_upon_match
    assert_equal 263396013, item_repo.find_by_name("Free standing Woden letters").id
    assert_equal 263396013, item_repo.find_by_name("Free standing WODen letters").id
  end

  def test_find_all_by_name_for_no_matches
    assert_equal [], item_repo.find_all_with_description("fake")
  end

  def test_find_all_by_name_single_match
    assert_equal "Glitter scrabble frames", item_repo.find_all_with_description("Glitter scrabble")[0].name
  end

  def test_find_all_with_desc_multi_match
    assert_equal true, item_repo.find_all_with_description("Acrylique")[0].name.include?("Cache cache")
    assert_equal true, item_repo.find_all_with_description("Acrylique")[1].name.include?("Course")
  end

  def test_find_all_by_price_for_no_matches
    assert_equal [], item_repo.find_all_by_price(0.00)
  end

  def test_find_all_by_price_single_match
    assert_equal "Free standing Woden letters", item_repo.find_all_by_price(7.00)[0].name
  end

  def test_find_all_by_price_multi_match
    assert_equal true, item_repo.find_all_by_price(13.00)[0].name.include?("Glitter")
    assert_equal true, item_repo.find_all_by_price(13.00)[1].name.include?("Disney")
  end

  def test_find_all_by_price_range_for_no_matches
    assert_equal [], item_repo.find_all_by_price_in_range(10000.00..100000.00)
  end

  def test_find_all_by_price_in_range_single_match
    assert_equal true, item_repo.find_all_by_price_in_range(0.00.. 4.00)[0].name.include?("Fragrance Oils")
  end

  def test_find_all_by_price_in_range_multi_match
    assert_equal true, item_repo.find_all_by_price_in_range(150.00.. 10000.00)[1].name.include?("Custom Hand Made")
    assert_equal true, item_repo.find_all_by_price_in_range(150.00.. 10000.00)[0].name.include?("Course")
  end

  def test_find_by_merch_id_nil_for_unmatched
    assert_equal nil, item_repo.find_by_merchant_id(6)
  end

  def test_find_by_merch_id_returns_a_item_object
    assert_equal "Glitter scrabble frames", item_repo.find_by_merchant_id(12334185).name
  end

end
