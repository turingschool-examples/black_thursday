require './test/test_helper'
require './lib/sales_engine'
require './lib/merchant'


class MerchantTest < Minitest::Test

  def test_setup
    assert Merchant.new.class
  end
end
