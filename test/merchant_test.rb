# TODO: Make merchant tests!
require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new(name: 'Hello')
    assert_instance_of(Merchant, merchant)
  end
end
