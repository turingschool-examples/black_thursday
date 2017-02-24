require './test/test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_merchant_repository_exists
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv"})
    # se.merchant_repo is an instance of MerchantRepo class!
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_can_make_new_merchants
    skip
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv"})
    mr = se.merchant_repo
    assert "12334105", mr.create_merchants.first.id
  end

  def test_returns_all_merchants
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv"})
    mr = se.merchants
    assert_equal 475, mr.all.count
    assert_instance_of Array, mr.all
    assert_instance_of Merchant, mr.all.first
  end

  def test_find_by_id
    skip
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv"})
    mr = se.merchant_repo
    assert_instance_of Merchant, mr.find_by_id(12334105)
  end

end

# first row:
#<CSV::Row id:"12334105" name:"Shopin1901" created_at:"2010-12-10" updated_at:"2011-12-04">
# id,name,created_at,updated_at
# 12334105,Shopin1901,2010-12-10,2011-12-04
# 12334112,Candisart,2009-05-30,2010-08-29
# 12334113,MiniatureBikez,2010-03-30,2013-01-21
