require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_merchant_class_exist
    merchant = Merchant.new
    assert_instance_of Merchant, merchant
  end
end
