require 'pry'
require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exist
    merchant_repo = MerchantRepository.new("./data/merchants.csv", "salesengine")

    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_can_return_array_of_all_known_merchant_instances
    merchant_repo = MerchantRepository.new("./data/merchants.csv", "salesengine")

    assert_instance_of Array, merchant_repo.all
    assert_instance_of Merchant, merchant_repo.all[0]
  end

  def test_can_find_by_id
    merchant_repo = MerchantRepository.new("./data/merchants.csv", "salesengine")

    assert_nil merchant_repo.find_by_id("123")
    assert_instance_of Merchant, merchant_repo.find_by_id(12334105)
  end

  def test_it_can_find_by_name
    merchant_repo = MerchantRepository.new("./data/merchants.csv", "salesengine")

    assert_nil merchant_repo.find_by_name("Thisisafakenamenotinrepo")
    assert_instance_of Merchant, merchant_repo.find_by_name("CJsDecor")
  end

  def test_it_can_find_all_by_name
    merchant_repo = MerchantRepository.new("./data/merchants.csv", "salesengine")

    assert_equal [], merchant_repo.find_all_by_name("zzzz")
    assert_instance_of Merchant, merchant_repo.find_all_by_name("el")[0]

  end

end
