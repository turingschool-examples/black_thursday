require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new({id: 0, name: "Bob Saget"})
  end

  def test_merchant_exists
    assert_instance_of Merchant, @merchant
  end

  def test_merchant_has_attributes
    assert_equal 0, @merchant.id
    assert_equal "Bob Saget", @merchant.name
  end
end
