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
end
