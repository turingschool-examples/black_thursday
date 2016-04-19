require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_created_instance_of_merchant_class
    m = Merchant.new
    assert_equal Merchant, m.class
  end

  
end
