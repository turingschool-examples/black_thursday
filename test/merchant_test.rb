require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new(1234567, "aCoolMerchant")
  end

  def test_merchant_exists
    assert_instance_of Merchant, @merchant
  end

  def test_merchant_has_id
    assert_equal 1234567, @merchant.id
  end

  def test_merchant_has_name
    assert_equal "aCoolMerchant", @merchant.name
  end
end
