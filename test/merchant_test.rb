require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new
    assert_instance_of Merchant, merchant
  end
end
