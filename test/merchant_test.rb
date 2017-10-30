require './test/test_helper'

class MerchantTest < Minitest::Test

  def test_it_exists
    skip
    me = Merchant.new

    assert_instance_of Merchant, me
  end

  def test_can_be_initialized_with_attributes
    skip
    me = Merchant.new

    assert_equal 12334112, merchant.id
    assert_equal "Candisart", merchant.name
    assert_instance_of SalesEngine, merchant.engine
  end
end
