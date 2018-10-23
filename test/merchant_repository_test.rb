require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_merchant_reposity_exists
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of MerchantRepository, mr
  end

  def test_merchant_reposity_has_merchants
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of Merchant, mr.merchants_array[0]
  end

  def test_you_can_find_all_merchants
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_equal 475, mr.all.count
  end

  def test_you_can_find_merchant_by_id
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_equal mr.merchants_array[4], mr.find_by_id(12334123)
  end

  def test_you_can_find_merchants_by_name
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_equal mr.merchants_array[6], mr.find_by_name("GoldenRayPress")
  end

  def test_you_can_find_all_merchants_by_name
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_equal mr.merchants_array[6], mr.find_by_name("GoldenRayPress")
  end
end
