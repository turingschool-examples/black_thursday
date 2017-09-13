require_relative 'test_helper'
require_relative '../lib/merchant_repo'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_item_exists
    merchant_list = []
    merch = MerchantRepository.new(merchant_list)

    assert_instance_of MerchantRepository, merch
  end

  def test_all_merchants
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Candisart"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    merch = MerchantRepository.new(merchant_list)

    assert_equal 5, merch.all.count
  end

  def test_find_by_id
  end

  def test_find_by_name
  end

  def test_find_all_by_name
  end
end
