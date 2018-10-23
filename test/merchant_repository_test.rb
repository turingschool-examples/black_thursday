require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @mr = MerchantRepository.new
    @merchant_1 = Merchant.new({:id => 12334123, :name => "Keckenbauer"})
    @merchant_2 = Merchant.new({:id => 12334145, :name => "BowlsByChris"})
    @merchant_3 = Merchant.new({:id => 12334159, :name => "SassyStrangeArt"})
    @mr.add_merchant(@merchant_1)
    @mr.add_merchant(@merchant_2)
    @mr.add_merchant(@merchant_3)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_store_merchants
    expected = [@merchant_1, @merchant_2, @merchant_3]
    assert_equal expected, @mr.all
  end

  def test_it_can_find_merchant_by_id
    assert_equal @merchant_2, @mr.find_by_id(12334145)
  end

end
