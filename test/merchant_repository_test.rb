require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def test_find_by_id
    merchant_data1 = ['12334105','Shopin1901','2010-12-10','2011-12-04']
    merchant_data2 = ['12334112','Candisart','2009-05-30','2010-08-29']
    merchant1 = Merchant.new(merchant_data1)
    merchant2 = Merchant.new(merchant_data2)
    merchant_repository = MerchantRepository.new([])
    merchant_repository.merchants = [merchant1, merchant2]
    assert_equal merchant2, merchant_repository.find_by_id(12334112)
  end
end
