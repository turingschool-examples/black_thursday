require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/merchant_repository"
require "pry"

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    merchant = MerchantRepository.new("./data/merchants.csv", "se")

    assert_instance_of MerchantRepository, merchant
  end

  def test_Merchants_is_filled
    merchant = MerchantRepository.new("./data/merchants.csv", "se")

    assert_instance_of Merchant, merchant.merchants.first
    assert_instance_of Merchant, merchant.merchants.last
  end

  def test_it_returns_matches_by_id
    merchant = MerchantRepository.new("./data/merchants.csv", "se")
    found_id = merchant.find_by_id("12334220")

    assert_equal "CottonBeeWraps", found_id.name
  end

  def test_it_returns_matches_by_name
    merchant = MerchantRepository.new("./data/merchants.csv", "se")
    found_name = merchant.find_by_name("Snewzy")

    assert_equal "12334223", found_name.id
    refute_equal "123223", found_name.id
  end

  def test_it_returns_matches_for_all_by_name
    merchant = MerchantRepository.new("./data/merchants.csv", "se")
    found_names = merchant.find_all_by_name("un")

    assert_equal 19, found_names.count
    assert_includes found_names.first.name.downcase, "un"
  end

end
