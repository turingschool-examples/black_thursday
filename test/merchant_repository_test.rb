require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new("./test/merchants_sample.csv")
    assert_instance_of MerchantRepository, mr
  end

  def test_it_has_no_merchants
    mr = MerchantRepository.new("./test/merchants_sample.csv")
    assert_equal [], mr.merchants
  end

  def test_it_can_create_merchants
    mr = MerchantRepository.new("./test/merchants_sample.csv")
    assert_instance_of Merchant, mr.create_merchant(("./test/merchants_sample.csv"))
  end


end
