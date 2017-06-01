require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    merchant = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of MerchantRepository, merchant
  end

  def test_it_initiates_with_hash
    merchant = MerchantRepository.new("./data/merchants.csv")
    result = merchant.merchants
    assert_instance_of Array, result
  end

  def test_it_can_populate_array_with_all_475_merchants
    merchant = MerchantRepository.new("./data/merchants.csv")
    result = merchant.merchants
    assert_instance_of Array, result
    result2 = merchant.merchants
    assert_equal 475, result2.length
  end

  def test_find_by_name
    merchant = MerchantRepository.new("./data/merchants.csv")
    result = merchant.find_by_name("shopin1901")
    assert_equal "shopin1901", result.first.name
  end

  def test_merchants_carry_id
    merchant = MerchantRepository.new("./data/merchants.csv")
    result = merchant.find_by_id("12334105")
    assert_instance_of Merchant, result.first
  end

  def test_find_bys_return_nil_if_no_match
    merchant = MerchantRepository.new("./data/merchants.csv")
    result = merchant.find_by_name("Daniel")
    result2 = merchant.find_by_id("1233410115")
    assert_nil result
    assert_nil result2
  end

  def test_it_can_match_with_improper_case
    merchant = MerchantRepository.new("./data/merchants.csv")
    result = merchant.find_by_name("Shopin1901")
    assert_equal "shopin1901", result.first.name
  end

  def test_it_can_return_multiple_name_matches
    merchant = MerchantRepository.new("./data/merchants.csv")
    result = merchant.find_all_by_name('th')
    assert_instance_of Array, result
    assert_equal 40, result.length
  end

  def test_it_can_use_all_method
    merchant = MerchantRepository.new("./data/merchants.csv")
    all_merchants = merchant.all
    assert_equal 475, all_merchants.length
  end
end
