require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchant_exists
    merchant = Merchant.new(id, name, created_at, updated_at)

    assert_instance_of Merchant, merchant
  end

end
