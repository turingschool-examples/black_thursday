require './test/test_helper'

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
    assert_equal 10, mr.all
  end

  def test_merchant_repo_can_find_them_by_id
    mr = MerchantRepository.new("./test/merchant_sample.csv")
    assert_instance_of Merchant, mr.find_by_id(12334105)
  end

  def test_merchant_repo_can_find_them_by_name
    mr = MerchantRepository.new("./test/merchant_sample.csv")
    assert_instance_of Merchant, mr.find_by_name('Shopin1901')
  end

end
