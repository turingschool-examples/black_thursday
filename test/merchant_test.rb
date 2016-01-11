require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'


class MerchantTest < Minitest::Test
  def test_an_instance_merchant_exists
    merchant = Merchant.new
    assert merchant.instance_of?(Merchant)
  end

  def test_an_instance_of_merchance_can_be_created_by_arg
  end

end
