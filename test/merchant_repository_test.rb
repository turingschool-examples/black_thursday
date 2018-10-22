require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_store_merchants
    mr = MerchantRepository.new
    merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    merchant_2 = Merchant.new({:id => 7, :name => "Disney"})
    mr.add_merchant(merchant_1)
    mr.add_merchant(merchant_2)
    expected = [merchant_1, merchant_2]
    assert_equal expected, mr.all
  end
end
