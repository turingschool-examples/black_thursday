require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def setup
   @se = SalesEngine.from_csv({
     :items     => "./test/fixtures/items.csv",
     :merchants => "./test/fixtures/merchants.csv",})
   @merchant_repo = @se.merchants
  end


  def test_all_returns_array
    assert_equal Array, merch_repo.all.class
  end

  def test_returns_all_items_within_array
    assert_equal 10, merch_repo.all.length
  end

  def test_all_returns_merchant_objects
    skip
    assert_equal Merchant, merch_repo.all[7].class
  end

  def test_find_by_id_nil_for_a_unmatched
    skip
    assert_equal nil, merch_repo.find_by_id(6)
  end

  def test_find_by_id_upon_match
    skip
    assert_equal "GoldenRayPress", merch_repo.find_by_id(12334135).name
  end

  def test_find_by_name_nil_when_no_match
    skip
    assert_equal nil, merch_repo.find_by_name("fake")
  end

  def test_find_by_name_returns_merch_object
    skip
    assert_equal 12334135, merch_repo.find_by_name("GoldenRayPress").id
    assert_equal 12334135, merch_repo.find_by_name("GOLDENRAYPRESS").id
  end

  def test_find_all_by_name_empty_unmatched
    skip
    assert_equal [], merch_repo.find_all_by_name("fake")
  end

  def test_find_all_by_name_single_match
    skip
    assert_equal "GoldenRayPress", merch_repo.find_all_by_name("Gol")[0].name
  end

  def test_find_all_by_name_multi_match
    skip
    assert_equal "Shopin1901", merch_repo.find_all_by_name("Shop")[0].name
    assert_equal "Shopin1902", merch_repo.find_all_by_name("Shop")[1].name
  end

end
