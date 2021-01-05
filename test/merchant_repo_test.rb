require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'

class MerchantRepositoryTest < MiniTest::Test

  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_build_merchants
    mr = MerchantRepository.new
    mers = mr.build_merchants

    assert_equal 475, mr.build_merchants.count
  end
end
