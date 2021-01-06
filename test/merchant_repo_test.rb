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

  def test_find_by_id
    #12334207,BloominScents,2004-02-26,2012-08-03
    mr = MerchantRepository.new
    mr.build_merchants
    merchant1 = mr.find_by_id(12334207)
    merchant0 = mr.find_by_id(1)

    assert_equal [mr.build_merchants[25]], merchant1
    assert_nil merchant0
  end

  def test_find_by_name
    mr = MerchantRepository.new
    mr.build_merchants
    merchant1 = mr.find_by_name("Shopin1901")
    merchant2 = mr.find_by_name("NERDGEEKs")

    assert_equal "Shopin1901", merchant1[0].name
    assert_equal "NERDGEEKs".capitalize, merchant2[0].name
  end

  def test_find_all_by_name
    mr = MerchantRepository.new
    mr.build_merchants
    merchant1 = mr.find_all_by_name("cUStoM")
    merchant2 = mr.find_by_name("NERDGEEKs")

    assert_equal 7, merchant1.count
  end
end
