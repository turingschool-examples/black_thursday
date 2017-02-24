require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_1, :merchant_2, :merchant_3, :merchant_4, :merchants, :mr
  def setup
    @merchant_1 = Merchant.new(id:"12334105", name:"Shopin1901", created_at:"2010-12-10", updated_at:"2011-12-04")
    @merchant_2 = Merchant.new(id:"12334112", name:"Candisart", created_at:"2009-05-30", updated_at:"2010-08-29")
    @merchant_3 = Merchant.new(id:"12334113", name:"MiniatureBikez", created_at:"2010-03-30", updated_at:"2013-01-21")
    @merchant_4 = Merchant.new(id:"12334657", name:"Shopin1901", created_at:"2010-09-10", updated_at:"2011-12-03")

    @merchants = [merchant_1, merchant_2, merchant_3, merchant_4]
    @mr = MerchantRepository.new(merchants)
  end

  def test_it_exists
    assert MerchantRepository
  end

  def test_all_merchants_array
    assert_equal merchants, mr.all
  end

  def test_find_by_id
    assert_equal merchant_1, mr.find_by_id(12334105)
  end

  def test_find_by_name
    assert_equal merchant_2, mr.find_by_name("Candisart")
  end

  def test_find_all_by_name
    expected = [merchant_1,merchant_4]
    assert_equal expected, mr.find_all_by_name("Shopin1901")
  end

  def test_find_by_name_returns_empty_array
    expected =[]
    assert_equal expected, mr.find_all_by_name("Puppies-R-US")
  end
end
