require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    merchant_data1 = ['12334105','Shopin1901','2010-12-10','2011-12-04']
    merchant_data2 = ['12334112','Candisart','2009-05-30','2010-08-29']
    merchant_data3 = ['23625362','Candisart','1997-02-24','2007-12-25']
    @merchant1 = Merchant.new(merchant_data1)
    @merchant2 = Merchant.new(merchant_data2)
    @merchant3 = Merchant.new(merchant_data3)
    @merchant_repository = MerchantRepository.new([])
    @merchant_repository.merchants = [@merchant1, @merchant2, @merchant3]
  end

  def test_all_merchants_are_present
    assert_equal [@merchant1,@merchant2,@merchant3], @merchant_repository.all
  end

  def test_find_by_id
    assert_equal @merchant2, @merchant_repository.find_by_id(12334112)
  end

  def test_find_by_id_nil
    assert_equal nil, @merchant_repository.find_by_id(57396729)
  end

  def test_find_by_name
    assert_equal @merchant2, @merchant_repository.find_by_name("Candisart")
  end

  def test_find_by_name_nil
    assert_equal nil, @merchant_repository.find_by_name("Lane")
  end

  def test_find_all_by_name
    assert_equal [@merchant2, @merchant3], @merchant_repository.find_all_by_name("Can")
  end

  def test_find_all_by_name_empty
    assert_equal [], @merchant_repository.find_all_by_name("Lane")
  end
end
