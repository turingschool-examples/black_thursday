require './test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_merchant_exists
    attributes = {:id => 5, :name => 'Turing School'}
    merchant = Merchant.new(attributes)

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end
end
