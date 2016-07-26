require "./test/test_helper"
require "./lib/merchant_repo"

class MerchantsRepoTest < Minitest::Test

  def test_it_can_retun_the_full_merchant_count
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal 99, merch_repo.all.count
  end

  def test_it_can_find_a_merchant_via_id_number
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal "FrenchiezShop", merch_repo.find_by_id("12334473")
  end

  def test_nil_is_returned_when_id_doesnt_match
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal nil, merch_repo.find_by_id("123355553")
  end

  def test_it_can_find_a_merchant_by_name
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal "byMarieinLondon", merch_repo.find_by_name("byMarieinLondon")
  end

  def test_it_returns_nil_if_name_doesnt_match
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal nil, merch_repo.find_by_name("byMarieinLon")
  end

  def test_it_finds_name_regardless_of_case
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    name = "byMarieinLondon".downcase
    assert_equal "byMarieinLondon", merch_repo.find_by_name(name)
  end

  def test_it_can_find_merchants_by_name_fragment
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal 7, merch_repo.find_all_by_name("the").count
  end

  def test_it_can_find_merchants_regardless_of_case
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal 11, merch_repo.find_all_by_name("to").count
  end



end
