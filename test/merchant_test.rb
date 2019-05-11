require_relative 'test_helper'
require_relative '../lib/elementals/merchant'

# merchant class
class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new(id: 1234567, name: 'aCoolMerchant')
  end

  def test_merchant_exists
    assert_instance_of Merchant, @merchant
  end

  def test_merchant_has_id
    assert_equal 1234567, @merchant.id
  end

  def test_merchant_has_name
    assert_equal 'aCoolMerchant', @merchant.name
  end
end
