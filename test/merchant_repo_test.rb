require_relative 'test/test_helper'
require_relative 'lib/merchant_repo'
require_relative 'lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_item_exists
    merch = MerchantRepository.new

    assert_instance_of MerchantRepository, merch
  end

  def test_all_merchants
    merch = MerchantRepository.new([{:id=>"12334105", :name=>"Shopin1901"},
 {:id=>"12334112", :name=>"Candisart"},
 {:id=>"12334113", :name=>"MiniatureBikez"},
 {:id=>"12334115", :name=>"LolaMarleys"},
 {:id=>"12334123", :name=>"Keckenbauer"}])

    assert_equal 5, merch.all.count
  end

  def test_find_by_id
  end

  def test_find_by_name
  end

  def test_find_all_by_name
  end
end
