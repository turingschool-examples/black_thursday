require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'


class MerchantRepositoryTest < Minitest::Test


  attr_reader :merch_repo, :se
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})

    # require 'pry'; binding.pry
    @se.merchants
    @merch_repo = @se.merchant_repository
  end

  def test_all_returns_array
    assert_equal Array, merch_repo.all.class
  end

  def test_returns_all_items_within_array
    assert_equal 10, merch_repo.all.length
  end

  def test_all_returns_array_of_merchant_objects
    assert_equal Merchant, merch_repo.all[7].class
  end

  def test_find_by_id_returns_nil_for_a_unmatched_ID
    assert_equal nil, merch_repo.find_by_id(6)
  end

  def test_find_by_id_returns_a_merchant_object_upon_match
    assert_equal "GoldenRayPress", merch_repo.find_by_id(12334135).name
  end

  def test_find_by_name_returns_nil_when_no_match
    assert_equal nil, merch_repo.find_by_name("fake")
  end

  def test_find_by_name_returns_merch_object_upon_match
    assert_equal 12334135, merch_repo.find_by_name("GoldenRayPress").id
    assert_equal 12334135, merch_repo.find_by_name("GOLDENRAYPRESS").id
  end

  def test_find_all_by_name_returns_empty_array_for_no_matches
    assert_equal [], merch_repo.find_all_by_name("fake")
  end

  def test_find_all_by_name_single_match
    assert_equal "GoldenRayPress", merch_repo.find_all_by_name("Gol")[0].name
  end

  def test_find_all_by_name_multi_match
    assert_equal "Shopin1901", merch_repo.find_all_by_name("Shop")[0].name
    assert_equal "Shopin1902", merch_repo.find_all_by_name("Shop")[1].name
  end

end
