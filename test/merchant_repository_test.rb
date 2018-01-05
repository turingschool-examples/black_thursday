require_relative 'test_helper'
require_relative "../lib/merchant_repository"

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    merchant = MerchantRepository.new("./test/fixtures/merchants_sample.csv", "se")

    assert_instance_of MerchantRepository, merchant
  end

  def test_Merchants_is_filled
    merchant = MerchantRepository.new("./test/fixtures/merchants_sample.csv", "se")

    assert_instance_of Merchant, merchant.merchants.first
    assert_instance_of Merchant, merchant.merchants.last
  end

  def test_it_returns_matches_by_id
    merchant = MerchantRepository.new("./test/fixtures/merchants_sample.csv", "se")
    found_id = merchant.find_by_id(12334185)

    assert_equal "Madewithgitterxx", found_id.name
  end

  def test_it_returns_matches_by_name
    merchant = MerchantRepository.new("./test/fixtures/merchants_sample.csv", "se")
    found_name = merchant.find_by_name("FlavienCouche")

    assert_equal 12334195, found_name.id
    refute_equal "123223", found_name.id
  end

  def test_it_returns_matches_for_all_by_name
    merchant = MerchantRepository.new("./test/fixtures/merchants_sample.csv", "se")
    found_names = merchant.find_all_by_name("an")

    assert_equal 1, found_names.count
    assert_includes found_names.first.name.downcase, "an"
  end

end
