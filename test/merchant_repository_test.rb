require_relative 'test_helper'
require_relative '../lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_can_hold_merchants
    assert_instance_of Array, @merchant_repository.merchants
  end

  def test_it_holding_merchants
    assert_instance_of Merchant, @merchant_repository.merchants[0]
    assert_instance_of Merchant, @merchant_repository.merchants[25]
  end

  def test_it_can_return_merchants_using_all
    assert_instance_of Merchant, @merchant_repository.all[5]
    assert_instance_of Merchant, @merchant_repository.all[97]
  end
end
