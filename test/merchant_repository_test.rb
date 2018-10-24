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
    assert_equal 10, mr.all.count
  end

  def test_merchant_repo_can_find_them_by_id
    mr = MerchantRepository.new("./test/merchant_sample.csv")
    assert_instance_of Merchant, mr.find_by_id(12334105)
  end

  def test_merchant_repo_can_find_them_by_name
    mr = MerchantRepository.new("./test/merchant_sample.csv")
    assert_instance_of Merchant, mr.find_by_name('Shopin1901')
  end

  def test_merchant_repo_can_find_them_all_by_name
    mr = MerchantRepository.new("./test/merchant_sample.csv")
    assert_equal [], mr.find_all_by_name('1901')
  end

  # def test_merchant_repo_can_create_a_merchant
  #   mr = MerchantRepository.new("./test/merchant_sample.csv")
  #   new_merchant = mr.create({:name => 'Duck'})
  #   assert_instance_of Merchant, new_merchant
  #   assert_equal 12334156, new_merchant.id
  # end

end
