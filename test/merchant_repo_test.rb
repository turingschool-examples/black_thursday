require_relative 'test_helper'
require_relative '../lib/merchant_repo'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo, :sales_engine

  def set_up(merchants = [])
    @sales_engine = SalesEngine.new
    @merchant_repo = MerchantRepository.new(merchants, sales_engine)
    @sales_engine.merchants = merchant_repo
  end

  def test_merchant_exists
    set_up
    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_all_merchants
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Candisart"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    set_up(merchant_list)

    assert_equal 5, merchant_repo.all.count
  end

  def test_find_by_id_nil
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Candisart"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    set_up(merchant_list)

    assert_nil merchant_repo.find_by_id(39472)
  end

  def test_find_specific_id
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Candisart"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    set_up(merchant_list)

    assert_instance_of Merchant, merchant_repo.find_by_id(12334115)
  end

  def test_find_by_name_nil
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Candisart"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    set_up(merchant_list)

    assert_nil merchant_repo.find_by_name("Gerald")
  end

  def test_find_specific_name
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Candisart"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    set_up(merchant_list)
    name = "MiniatureBikez".upcase
    assert_instance_of Merchant, merchant_repo.find_by_name(name)
  end

  def test_find_all_by_name
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Candisart"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    set_up(merchant_list)
    fragment = "Goboababab"

    assert_equal [], merchant_repo.find_all_by_name(fragment)
  end

  def test_find_all_by_name_specific_name
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Candisart"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    set_up(merchant_list)
    fragment = "Shop"

    assert_equal 1, merchant_repo.find_all_by_name(fragment).count
  end

  def test_find_all_by_name_specific_name_again
    merchant_list = []
    merchant_list << merch1 = Merchant.new({:id=>"12334105", :name=>"Shopin1901"})
    merchant_list << merch2 = Merchant.new({:id=>"12334112", :name=>"Shop30943"})
    merchant_list << merch3 = Merchant.new({:id=>"12334113", :name=>"MiniatureBikez"})
    merchant_list << merch4 = Merchant.new({:id=>"12334115", :name=>"LolaMarleys"})
    merchant_list << merch5 = Merchant.new({:id=>"12334123", :name=>"Keckenbauer"})

    set_up(merchant_list)
    fragment = "Shop"

    assert_equal 2, merchant_repo.find_all_by_name(fragment).count
  end
end
