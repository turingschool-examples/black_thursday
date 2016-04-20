require './test/test_helper'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  # def setup
  #   merchant_data1 = ['12334105','Shopin1901','2010-12-10','2011-12-04']
  #   merchant_data2 = ['12334112','Candisart','2009-05-30','2010-08-29']
  #   merchant_data3 = ['23625362','Candisart','1997-02-24','2007-12-25']
  #   merchant_data = [merchant_data1, merchant_data2, merchant_data3]
  #   engine = SalesEngine.new(merchant_data, [])
  #   @merchant1 = Merchant.new(merchant_data1, )
  #   @merchant2 = Merchant.new(merchant_data2, )
  #   @merchant3 = Merchant.new(merchant_data3, )
    # @merchant_repository = MerchantRepository.new([], engine)
    # @merchant_repository.merchants = [@merchant1, @merchant2, @merchant3]
  # end

  def test_all_merchants_are_present
    assert_equal 5, @engine.merchants.all.count
    assert_equal "Shopin1901", @engine.merchants.all.first.merchant_data['name']
    assert_equal "GoldenRayPress", @engine.merchants.all.last.merchant_data['name']
  end

  def test_find_by_id
    skip
    assert_equal @merchant2, @merchant_repository.find_by_id()
  end

  def test_find_by_id_nil
    skip
    assert_equal nil, @merchant_repository.find_by_id(57396729)
  end

  def test_find_by_name
    skip
    assert_equal @merchant2, @merchant_repository.find_by_name("Candisart")
  end

  def test_find_by_name_nil
    skip
    assert_equal nil, @merchant_repository.find_by_name("Lane")
  end

  def test_find_all_by_name
    skip
    assert_equal [@merchant2, @merchant3], @merchant_repository.find_all_by_name("Can")
  end

  def test_find_all_by_name_empty
    skip
    assert_equal [], @merchant_repository.find_all_by_name("Lane")
  end
end
