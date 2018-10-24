require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new('./test/merchant_sample.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_create_merchants
    mr = MerchantRepository.new("./test/merchant_sample.csv")
    assert_instance_of Array, mr.create_merchant("./test/merchant_sample.csv")
  end

  def test_merchant_repo_has_merchants
    mr = MerchantRepository.new("./test/merchant_sample.csv")
    assert_equal 13 , mr.all.count
    assert_instance_of Array, mr.all
  end

end
