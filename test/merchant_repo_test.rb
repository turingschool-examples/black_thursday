require "./test/test_helper"
require "./lib/merchant_repo"

class MerchantsRepoTest < Minitest::Test

  def test_it_can_retun_the_full_merchant_count
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal 100, merch_repo.all.count
  end

  def test_it_can_find_a_merchant_via_id_number
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal "FrenchiezShop", merch_repo.find_by_id("12334473").name
  end

  def test_nil_is_returned_when_id_doesnt_match
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal nil, merch_repo.find_by_id("123355553")
  end

  def test_it_can_find_a_merchant_by_name
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal "byMarieinLondon", merch_repo.find_by_name("byMarieinLondon").name
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
    assert_equal "byMarieinLondon", merch_repo.find_by_name(name).name
  end

  def test_invalid_charecterin_name
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    name = "by Mariein London".downcase
    assert_equal nil, merch_repo.find_by_name(name)
  end

  def test_nil_when_special_charecter_is_present
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    name = "by-Mariein~London".downcase
    assert_equal nil, merch_repo.find_by_name(name)
  end

  def test_what_about_merchant_with_comma_in_name
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    name = "ben,store".downcase
    assert_equal "ben,store", merch_repo.find_by_name(name).name
  end

  def test_it_can_find_merchants_by_name_fragment
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal 7, merch_repo.find_all_by_name("the").count
  end

  def test_it_can_find_merchants_regardless_of_case
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal 12, merch_repo.find_all_by_name("to").count
  end

  def test_an_emprty_array_is_returned_if_not_fragment_id_present
    filepath = "./data/support/merchant_support.csv"
    merch_repo = MerchantsRepo.new(filepath)
    assert_equal [], merch_repo.find_all_by_name("ejwdf")
  end

  def test_it_finds_customers_who_worked_with_a_merchant
    filepath = "./data/support/merchant_support.csv"
    mock_se = Minitest::Mock.new
    mock_se.expect(:find_all_customers_by_merchant_id, [1,2], [12334155])
    merch_repo = MerchantsRepo.new(filepath, mock_se)

    assert_equal 2, merch_repo.find_all_customers_by_merchant_id(12334155).count
    assert mock_se.verify
  end
end
