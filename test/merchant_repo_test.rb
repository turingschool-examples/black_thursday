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
    mr.build_merchants

    expect = "Shopin1901"

    assert_equal expect, mr.build_merchants[0].name 
  end
end
