require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    m = Merchant.new({id: 5, name: "Turing School"})
    assert_instance_of Merchant, m 
  end
end
