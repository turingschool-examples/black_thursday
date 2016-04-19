require './test/test_helper'
require './lib/merchant'
require './lib/sales_engine'



class MerchantTest < Minitest::Test

  def test_setup
    assert Merchant.new.class
  end
end
