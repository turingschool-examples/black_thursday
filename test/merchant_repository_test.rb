gem 'minitest'
require 'minitest/autorun'
require './lib/merchant_repository'
require './lib/sales_engine'
class MerchantRepositoryTest < Minitest::Test

  def test_merchant_repository_exists
    se = SalesEngine.new("./data/merchants.csv")
    mr = se.merchants
    assert_instance_of CSV, mr
  end

  # def test_returns_all_merchants
  #   se = SalesEngine.new("./data/merchants.csv")
  #   mr = se.merchants
  #   merchant = mr.find_by_name("CJsDecor")
  # 
  #   assert_instance_of Merchant, merchant
  # end



end


# id,name,created_at,updated_at
# 12334105,Shopin1901,2010-12-10,2011-12-04
# 12334112,Candisart,2009-05-30,2010-08-29
# 12334113,MiniatureBikez,2010-03-30,2013-01-21
