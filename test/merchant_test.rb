require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < MiniTest::Test

  def test_it_exists
    merchant = Merchant.new

    assert_instance_of Merchant, merchant
  end
end
