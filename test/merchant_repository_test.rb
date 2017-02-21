gem 'minitest'
require 'minitest/autorun'
require './lib/merchant_reposity'

class MerchantRepositoryTest < Minitest::Test

  def test_merchant_repository_exists
    skip
    # building sales engine first
    merchant_repo = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    assert_equal merchant_object, merchant
  end
end


# id,name,created_at,updated_at
# 12334105,Shopin1901,2010-12-10,2011-12-04
# 12334112,Candisart,2009-05-30,2010-08-29
# 12334113,MiniatureBikez,2010-03-30,2013-01-21
