require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'
require 'pry'

class MerchantRepoTest < MiniTest::Test

  def test_it_exists
    mr = MerchantRepo.new("./data/merchants.csv")

    assert_instance_of MerchantRepo, mr
  end

  def test_all_returns_all_merchants
    merchants = MerchantRepo.new("./data/merchants.csv")

    assert_equal 475, merchants.all.count
  end

  def test_find_by_id_returns_matching_id
    merchants = MerchantRepo.new("./data/merchants.csv")

    assert_equal "ElisabettaComotto", merchants.find_by_id("12334228").name
    assert_nil merchants.find_by_id("777777")
  end

  def test_find_by_name_returns_matching_name
    merchants = MerchantRepo.new("./data/merchants.csv")

    assert_equal "12334228", merchants.find_by_name("ElisabettaComotto").id
    assert_equal "12334228", merchants.find_by_name("ELISABETTACOMOTTO").id
  end

  def test_find_by_returns_nil_if_no_match
    merchants = MerchantRepo.new("./data/merchants.csv")

    assert_nil merchants.find_by_name("xxxxxxxxxx")
  end

  def test_find_all_by_name_returns_all_with_match
    merchants = MerchantRepo.new("./data/merchants.csv")

    assert_equal 26, merchants.find_all_by_name("shop").count
    assert_equal 26, merchants.find_all_by_name("SHOP").count
  end

  def test_find_all_by_name_returns_empty_array_if_no_match
    merchants = MerchantRepo.new("./data/merchants.csv")

    assert_equal [], merchants.find_all_by_name("xxxxxxxxxx")
  end
end
